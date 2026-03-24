import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

@RoutePage()
class TimelapseScreen extends StatefulWidget {
  const TimelapseScreen({super.key});

  @override
  State<TimelapseScreen> createState() => _TimelapseScreenState();
}

class _TimelapseScreenState extends State<TimelapseScreen> {
  CameraController? _controller;
  bool _isRecording = false;
  int _intervalSeconds = 5;
  DateTime? _startDate;
  DateTime? _endDate;
  Timer? _timer;
  Timer? _scheduleTimer;
  List<String> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(cameras.first, ResolutionPreset.medium, enableAudio: false);
    await _controller!.initialize();
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
    if (_startDate != null && _startDate!.isAfter(now)) {
      setState(() => _isRecording = true);
      _scheduleTimer = Timer(_startDate!.difference(now), _beginCapturing);
    } else {
      _beginCapturing();
    }
  }

  void _beginCapturing() {
    setState(() => _isRecording = true);
    WakelockPlus.enable();
    _timer = Timer.periodic(Duration(seconds: _intervalSeconds), (timer) {
      final now = DateTime.now();
      if (_endDate != null && now.isAfter(_endDate!)) {
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

  Future<void> _pickDateTime(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
          if (isStart) {
            _startDate = dt;
          } else {
            _endDate = dt;
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
      appBar: AppBar(title: const Text('Timelapse')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    const Text('Interval (seconds):'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Slider(
                        value: _intervalSeconds.toDouble(),
                        min: 1,
                        max: 60,
                        divisions: 59,
                        label: _intervalSeconds.toString(),
                        onChanged: _isRecording ? null : (val) => setState(() => _intervalSeconds = val.toInt()),
                      ),
                    ),
                    Text('$_intervalSeconds s'),
                  ],
                ),
                ListTile(
                  title: const Text('Start Date'),
                  subtitle: Text(_startDate == null ? 'Immediate' : DateFormat.yMd().add_Hm().format(_startDate!)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _isRecording ? null : () => _pickDateTime(true),
                ),
                ListTile(
                  title: const Text('End Date'),
                  subtitle: Text(_endDate == null ? 'Manual Stop' : DateFormat.yMd().add_Hm().format(_endDate!)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _isRecording ? null : () => _pickDateTime(false),
                ),
                const Divider(),
                ElevatedButton(
                  onPressed: _toggleRecording,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_isRecording ? 'STOP' : 'START'),
                ),
                const SizedBox(height: 16),
                const Text('Recent Snapshots:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _capturedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.file(File(_capturedImages[index]), width: 100, height: 100, fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
