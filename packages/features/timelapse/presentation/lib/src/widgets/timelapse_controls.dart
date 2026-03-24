import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/timelapse_settings.dart';
import '../navigation/router.gr.dart';

class TimelapseControls extends StatelessWidget {
  final TimelapseSettings settings;
  final bool isRecording;
  final List<String> capturedImages;
  final VoidCallback onResetSettings;
  final VoidCallback onShowCurtain;
  final VoidCallback onToggleRecording;
  final Function(bool isStart) onPickDateTime;
  final ValueSetter<int> onIntervalChanged;

  const TimelapseControls({
    super.key,
    required this.settings,
    required this.isRecording,
    required this.capturedImages,
    required this.onResetSettings,
    required this.onShowCurtain,
    required this.onToggleRecording,
    required this.onPickDateTime,
    required this.onIntervalChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: onShowCurtain,
                icon: const Icon(Icons.visibility_off, color: Colors.white70, size: 18),
                label: const Text('Curtain', style: TextStyle(color: Colors.white70, fontSize: 12)),
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
              ),
              if (!isRecording)
                TextButton.icon(
                  onPressed: onResetSettings,
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
                  value: settings.intervalSeconds.toDouble(),
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: '${settings.intervalSeconds} s',
                  onChanged: isRecording ? null : (val) => onIntervalChanged(val.toInt()),
                ),
              ),
              Text(
                '${settings.intervalSeconds} s',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _buildListTile(
            icon: Icons.calendar_today,
            title: 'Start Time',
            subtitle: settings.startDate == null ? 'Immediate' : DateFormat.yMd().add_Hms().format(settings.startDate!),
            onTap: isRecording ? null : () => onPickDateTime(true),
          ),
          _buildListTile(
            icon: Icons.event_busy,
            title: 'End Time',
            subtitle: settings.endDate == null ? 'Manual Stop' : DateFormat.yMd().add_Hms().format(settings.endDate!),
            onTap: isRecording ? null : () => onPickDateTime(false),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onToggleRecording,
            icon: Icon(isRecording ? Icons.stop_circle : Icons.play_circle_filled),
            label: Text(isRecording ? 'STOP' : 'START'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isRecording ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
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
              itemCount: capturedImages.length,
              itemBuilder: (context, index) {
                final path = capturedImages[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => context.router.push(ImagePreviewRoute(imagePath: path)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(path), width: 80, height: 80, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
