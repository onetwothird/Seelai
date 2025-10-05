
import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final bool isScanning;
  final VoidCallback onToggleScanning;

  const CameraControls({
    Key? key,
    required this.isScanning,
    required this.onToggleScanning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ControlButton(
                icon: Icons.flash_on,
                label: 'Flash',
                color: const Color(0xFFFFC107),
                onTap: () {},
              ),
              GestureDetector(
                onTap: onToggleScanning,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isScanning
                          ? [const Color(0xFFFF5252), const Color(0xFFD32F2F)]
                          : [const Color(0xFF00BCD4), const Color(0xFF0097A7)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isScanning ? const Color(0xFFFF5252) : const Color(0xFF00BCD4))
                            .withOpacity(0.5),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    isScanning ? Icons.stop_rounded : Icons.camera_alt_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              _ControlButton(
                icon: Icons.volume_up,
                label: 'Audio',
                color: const Color(0xFF2196F3),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isScanning ? Icons.mic : Icons.mic_none,
                  color: isScanning ? const Color(0xFF00BCD4) : Colors.white54,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  isScanning ? 'Text-to-Speech Active' : 'Tap to Enable Audio',
                  style: TextStyle(
                    color: isScanning ? Colors.white : Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}