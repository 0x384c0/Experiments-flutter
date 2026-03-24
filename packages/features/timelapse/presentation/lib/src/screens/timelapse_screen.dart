import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../data/timelapse_settings.dart';
import '../widgets/seconds_picker.dart';
import '../widgets/timelapse_controls.dart';

@RoutePage()
class TimelapseScreen extends StatefulWidget {
  const TimelapseScreen({super.key});

  @override
  State<TimelapseScreen> createState() => _TimelapseScreenState();
}

class _TimelapseScreenState extends State<TimelapseScreen> {
  CameraController? _controller;
  bool _isRecording = false;
  TimelapseSettings _settings = const TimelapseSettings();
  Timer? _timer;
  Timer? _scheduleTimer;
  final List<String> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadSavedImages();
    await _initializeCamera();
  }

  Future<void> _loadSavedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final timelapseDir = Directory(p.join(directory.path, 'timelapse'));
    if (await timelapseDir.exists()) {
      final files = timelapseDir.listSync().whereType<File>().toList();
      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      setState(() {
        _capturedImages.addAll(files.map((f) => f.path));
      });
    }
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
      final XFile image = await _controller!.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final timelapseDir = Directory(p.join(directory.path, 'timelapse'));
      if (!await timelapseDir.exists()) {
        await timelapseDir.create(recursive: true);
      }

      final String fileName = 'timelapse_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String permanentPath = p.join(timelapseDir.path, fileName);

      await File(image.path).copy(permanentPath);
      await File(image.path).delete();

      setState(() {
        _capturedImages.insert(0, permanentPath);
      });
    } catch (e) {
      debugPrint('Error taking snapshot: $e');
    }
  }

  void _resetSettings() {
    setState(() {
      _settings = const TimelapseSettings();
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
        builder: (context) => SecondsPicker(
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
                        child: TimelapseControls(
                          settings: _settings,
                          isRecording: _isRecording,
                          capturedImages: _capturedImages,
                          onResetSettings: _resetSettings,
                          onToggleRecording: _toggleRecording,
                          onPickDateTime: _pickDateTime,
                          onIntervalChanged: (val) =>
                              setState(() => _settings = _settings.copyWith(intervalSeconds: val)),
                        ),
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
}
