import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';

class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> with SingleTickerProviderStateMixin {
  bool _isRecognizing = false;
  String _recognizedPerson = '';
  bool _isCaretaker = false;
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  void _toggleRecognition() {
    setState(() {
      _isRecognizing = !_isRecognizing;
      if (_isRecognizing) {
        _scanController.repeat();
        _recognizedPerson = 'Analyzing face...';
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _recognizedPerson = 'Maria Santos';
              _isCaretaker = true;
              _scanController.stop();
            });
          }
        });
      } else {
        _recognizedPerson = '';
        _isCaretaker = false;
        _scanController.stop();
      }
    });
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  colors: [Color(0xFF0A0E27), Color(0xFF1A1F3A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [Color(0xFFF5F7FA), Color(0xFFE8EBF2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isDark),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: _isCaretaker
                          ? AppTheme.greenAccent
                          : isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.05),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isCaretaker
                            ? AppTheme.greenAccent.withOpacity(0.3)
                            : Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_isRecognizing && !_isCaretaker)
                        AnimatedBuilder(
                          animation: _scanController,
                          builder: (context, child) {
                            return CustomPaint(
                              size: const Size(300, 300),
                              painter: FaceScanPainter(_scanController.value),
                            );
                          },
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              gradient: _isCaretaker
                                  ? const LinearGradient(
                                      colors: [AppTheme.greenAccent, Color(0xFF66BB6A)],
                                    )
                                  : _isRecognizing
                                      ? const LinearGradient(
                                          colors: [AppTheme.blueAccent, Color(0xFF6B5CE7)],
                                        )
                                      : LinearGradient(
                                          colors: isDark
                                              ? [const Color(0xFF252B49), const Color(0xFF1A1F3A)]
                                              : [Colors.white, const Color(0xFFF0F2F5)],
                                        ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _isCaretaker
                                      ? AppTheme.greenAccent.withOpacity(0.4)
                                      : Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.face_rounded,
                              size: 80,
                              color: (_isRecognizing || _isCaretaker)
                                  ? Colors.white
                                  : isDark
                                      ? AppTheme.blueAccent
                                      : AppTheme.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 32),
                          if (_recognizedPerson.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 40),
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: _isCaretaker
                                    ? const LinearGradient(
                                        colors: [AppTheme.greenAccent, Color(0xFF66BB6A)],
                                      )
                                    : const LinearGradient(
                                        colors: [AppTheme.blueAccent, Color(0xFF6B5CE7)],
                                      ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: (_isCaretaker ? AppTheme.greenAccent : AppTheme.blueAccent)
                                        .withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    _recognizedPerson,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (_isCaretaker) ...[
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.verified_rounded,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Trusted Caretaker',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildControlButton(context, isDark),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : const Color(0xFF1A1F3A),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppTheme.blueAccent, Color(0xFF6B5CE7)],
            ).createShader(bounds),
            child: Text(
              'Face Recognition',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: _toggleRecognition,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            gradient: _isRecognizing
                ? _isCaretaker
                    ? const LinearGradient(colors: [AppTheme.greenAccent, Color(0xFF66BB6A)])
                    : const LinearGradient(colors: [AppTheme.blueAccent, Color(0xFF6B5CE7)])
                : AppTheme.purpleGradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: (_isRecognizing
                    ? (_isCaretaker ? AppTheme.greenAccent : AppTheme.blueAccent)
                    : AppTheme.purpleAccent
                ).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isRecognizing ? Icons.stop_circle_rounded : Icons.play_circle_rounded,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                _isRecognizing ? 'Stop Recognition' : 'Start Recognition',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaceScanPainter extends CustomPainter {
  final double progress;

  FaceScanPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.blueAccent.withOpacity(0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final lineY = (size.height * progress) - (size.height / 2);

    // Draw scanning line
    canvas.drawLine(
      Offset(center.dx - 80, center.dy + lineY),
      Offset(center.dx + 80, center.dy + lineY),
      paint..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(FaceScanPainter oldDelegate) => true;
}
