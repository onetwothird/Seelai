import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VoiceCommandButton extends StatefulWidget {
  final bool isListening;
  final VoidCallback onTap;

  const VoiceCommandButton({
    Key? key,
    required this.isListening,
    required this.onTap,
  }) : super(key: key);

  @override
  State<VoiceCommandButton> createState() => _VoiceCommandButtonState();
}

class _VoiceCommandButtonState extends State<VoiceCommandButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          gradient: widget.isListening
              ? AppTheme.tealGradient
              : LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF252B49), const Color(0xFF1A1F3A)]
                      : [Colors.white, const Color(0xFFF0F2F5)],
                ),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: widget.isListening
                ? AppTheme.tealAccent.withOpacity(0.5)
                : isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isListening
                  ? AppTheme.tealAccent.withOpacity(0.3)
                  : isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.isListening)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(220, 220),
                    painter: SoundWavePainter(_controller.value),
                  );
                },
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: widget.isListening
                        ? Colors.white.withOpacity(0.2)
                        : AppTheme.tealAccent.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.isListening ? Icons.mic : Icons.mic_none_rounded,
                    size: 56,
                    color: widget.isListening
                        ? Colors.white
                        : isDark
                            ? AppTheme.tealAccent
                            : AppTheme.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.isListening ? 'Listening...' : 'Voice Command',
                  style: TextStyle(
                    color: widget.isListening
                        ? Colors.white
                        : isDark
                            ? Colors.white
                            : const Color(0xFF1A1F3A),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.isListening ? 'Tap to stop' : 'Tap to speak',
                  style: TextStyle(
                    color: widget.isListening
                        ? Colors.white.withOpacity(0.8)
                        : isDark
                            ? Colors.white.withOpacity(0.6)
                            : const Color(0xFF5A6082),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final double animationValue;

  SoundWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 3; i++) {
      final radius = 50.0 + (i * 30) + (animationValue * 40);
      final opacity = 0.4 - (i * 0.12);
      canvas.drawCircle(
        center,
        radius,
        paint..color = Colors.white.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(SoundWavePainter oldDelegate) => true;
}