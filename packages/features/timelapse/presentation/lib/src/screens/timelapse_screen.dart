import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class TimeOfDayWithSeconds {
  final int hour;
  final int minute;
  final int second;

  TimeOfDayWithSeconds({required this.hour, required this.minute, required this.second});
}

class _TimelapseSettings {
  final int intervalSeconds;
  final DateTime? startDate;
  final DateTime? endDate;

  const _TimelapseSettings({
    this.intervalSeconds = 5,
    this.startDate,
    this.endDate,
  });

  _TimelapseSettings copyWith({
    int? intervalSeconds,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _TimelapseSettings(
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

@RoutePage()
class TimelapseScreen extends StatefulWidget {
  const TimelapseScreen({super.key});

  @override
  State<TimelapseScreen> createState() => _TimelapseScreenState();
}

class _TimelapseScreenState extends State<TimelapseScreen> {
  CameraController? _controller;
  bool _isRecording = false;
  _TimelapseSettings _settings = const _TimelapseSettings();
  Timer? _timer;
  Timer? _scheduleTimer;
  final List<String> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await _controller!.initialize();
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scheduleTimer?.cancel();
    _controller?.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopTimelapse();
    } else {
      _startTimelapse();
    }
  }

  void _startTimelapse() {
    final now = DateTime.now();
    if (_settings.startDate != null && _settings.startDate!.isAfter(now)) {
      setState(() => _isRecording = true);
      _scheduleTimer = Timer(_settings.startDate!.difference(now), _beginCapturing);
    } else {
      _beginCapturing();
    }
  }

  void _beginCapturing() {
    setState(() => _isRecording = true);
    WakelockPlus.enable();
    _timer = Timer.periodic(Duration(seconds: _settings.intervalSeconds), (timer) {
      final now = DateTime.now();
      if (_settings.endDate != null && now.isAfter(_settings.endDate!)) {
        _stopTimelapse();
        return;
      }
      _takeSnapshot();
    });
  }

  void _stopTimelapse() {
    _timer?.cancel();
    _scheduleTimer?.cancel();
    WakelockPlus.disable();
    setState(() => _isRecording = false);
  }

  Future<void> _takeSnapshot() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();
      setState(() {
        _capturedImages.insert(0, image.path);
      });
    } catch (e) {
      debugPrint('Error taking snapshot: $e');
    }
  }

  void _resetSettings() {
    setState(() {
      _settings = const _TimelapseSettings();
    });
  }

  Future<void> _pickDateTime(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final initialDateTime = (isStart ? _settings.startDate : _settings.endDate) ?? DateTime.now();
      final time = await showDialog<TimeOfDayWithSeconds>(
        context: context,
        builder: (context) => _TimeWithSecondsPicker(
          initialTime: TimeOfDayWithSeconds(
            hour: initialDateTime.hour,
            minute: initialDateTime.minute,
            second: initialDateTime.second,
          ),
        ),
      );

      if (time != null && mounted) {
        setState(() {
          final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute, time.second);
          if (isStart) {
            _settings = _settings.copyWith(startDate: dt);
          } else {
            _settings = _settings.copyWith(endDate: dt);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Timelapse', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background Camera Preview
          Positioned.fill(
            child: OrientationBuilder(
              builder: (context, orientation) {
                final isPortrait = orientation == Orientation.portrait;
                final previewSize = _controller!.value.previewSize!;
                return FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: isPortrait ? previewSize.height : previewSize.width,
                    height: isPortrait ? previewSize.width : previewSize.height,
                    child: CameraPreview(_controller!),
                  ),
                );
              },
            ),
          ),
          // Semitransparent Controls Overlay
          OrientationBuilder(
            builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;
              return Align(
                alignment: isPortrait ? Alignment.bottomCenter : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: isPortrait ? double.infinity : 350,
                        height: isPortrait ? null : double.infinity,
                        constraints: BoxConstraints(
                          maxHeight: isPortrait ? MediaQuery.of(context).size.height * 0.6 : double.infinity,
                        ),
                        padding: const EdgeInsets.all(20),
                        color: Colors.black.withOpacity(0.4),
                        child: _buildControls(orientation),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControls(Orientation orientation) {
    final List<Widget> items = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (!_isRecording)
            TextButton.icon(
              onPressed: _resetSettings,
              icon: const Icon(Icons.refresh, color: Colors.white70, size: 18),
              label: const Text('Reset', style: TextStyle(color: Colors.white70, fontSize: 12)),
              style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            ),
        ],
      ),
      const Divider(color: Colors.white24),
      Row(
        children: [
          const Icon(Icons.timer, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Text('Interval:', style: TextStyle(color: Colors.white, fontSize: 14)),
          Expanded(
            child: Slider(
              value: _settings.intervalSeconds.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: '${_settings.intervalSeconds} s',
              onChanged: _isRecording
                  ? null
                  : (val) => setState(() => _settings = _settings.copyWith(intervalSeconds: val.toInt())),
            ),
          ),
          Text(
            '${_settings.intervalSeconds} s',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      _buildListTile(
        icon: Icons.calendar_today,
        title: 'Start Time',
        subtitle: _settings.startDate == null ? 'Immediate' : DateFormat.yMd().add_Hms().format(_settings.startDate!),
        onTap: _isRecording ? null : () => _pickDateTime(true),
      ),
      _buildListTile(
        icon: Icons.event_busy,
        title: 'End Time',
        subtitle: _settings.endDate == null ? 'Manual Stop' : DateFormat.yMd().add_Hms().format(_settings.endDate!),
        onTap: _isRecording ? null : () => _pickDateTime(false),
      ),
      const SizedBox(height: 12),
      ElevatedButton.icon(
        onPressed: _toggleRecording,
        icon: Icon(_isRecording ? Icons.stop_circle : Icons.play_circle_filled),
        label: Text(_isRecording ? 'STOP' : 'START'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _isRecording ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'Recent Snapshots',
        style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _capturedImages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(File(_capturedImages[index]), width: 80, height: 80, fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 13)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      onTap: onTap,
      dense: true,
    );
  }
}

class _TimeWithSecondsPicker extends StatefulWidget {
  final TimeOfDayWithSeconds initialTime;

  const _TimeWithSecondsPicker({required this.initialTime});

  @override
  State<_TimeWithSecondsPicker> createState() => _TimeWithSecondsPickerState();
}

class _TimeWithSecondsPickerState extends State<_TimeWithSecondsPicker> {
  late int hour;
  late int minute;
  late int second;

  @override
  void initState() {
    super.initState();
    hour = widget.initialTime.hour;
    minute = widget.initialTime.minute;
    second = widget.initialTime.second;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Time (H:M:S)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPickerRow('Hour', hour, 23, (v) => setState(() => hour = v)),
          _buildPickerRow('Min', minute, 59, (v) => setState(() => minute = v)),
          _buildPickerRow('Sec', second, 59, (v) => setState(() => second = v)),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(
          onPressed: () => Navigator.pop(context, TimeOfDayWithSeconds(hour: hour, minute: minute, second: second)),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildPickerRow(String label, int value, int max, ValueChanged<int> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: max.toDouble(),
            divisions: max == 0 ? 1 : max,
            onChanged: (v) => onChanged(v.toInt()),
          ),
        ),
        Text(value.toString().padLeft(2, '0'), style: const TextStyle(fontFamily: 'monospace')),
      ],
    );
  }
}
