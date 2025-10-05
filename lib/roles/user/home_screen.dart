
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'camera_detection_screen.dart';
import 'face_recognition_screen.dart';
import 'notifications_screen.dart';
import 'widgets/voice_command_button.dart';
import 'widgets/action_card.dart';
import 'widgets/sos_dialog.dart';
import 'theme/app_theme.dart';

class BlindFriendlyHomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  
  const BlindFriendlyHomeScreen({
    Key? key,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  State<BlindFriendlyHomeScreen> createState() => _BlindFriendlyHomeScreenState();
}

class _BlindFriendlyHomeScreenState extends State<BlindFriendlyHomeScreen> with SingleTickerProviderStateMixin {
  bool _isListening = false;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _toggleVoiceCommand() {
    setState(() {
      _isListening = !_isListening;
    });
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
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
          child: FadeTransition(
            opacity: _fadeController,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with glass effect
                  _buildHeader(context, isDark),
                  const SizedBox(height: 32),
                  
                  // Voice Command Button
                  VoiceCommandButton(
                    isListening: _isListening,
                    onTap: _toggleVoiceCommand,
                  ),
                  const SizedBox(height: 32),
                  
                  // Feature Grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ActionCard(
                          icon: Icons.camera_alt_rounded,
                          label: 'Object\nDetection',
                          gradient: AppTheme.tealGradient,
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CameraDetectionScreen()),
                            );
                          },
                        ),
                        ActionCard(
                          icon: Icons.face_rounded,
                          label: 'Face\nRecognition',
                          gradient: const LinearGradient(
                            colors: [AppTheme.blueAccent, Color(0xFF6B5CE7)],
                          ),
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FaceRecognitionScreen()),
                            );
                          },
                        ),
                        ActionCard(
                          icon: Icons.warning_rounded,
                          label: 'Emergency\nSOS',
                          gradient: const LinearGradient(
                            colors: [AppTheme.redAccent, Color(0xFFFF6B81)],
                          ),
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            showDialog(
                              context: context,
                              builder: (context) => const SOSDialog(),
                            );
                          },
                        ),
                        ActionCard(
                          icon: Icons.settings_rounded,
                          label: 'Settings',
                          gradient: AppTheme.purpleGradient,
                          onTap: () {
                            HapticFeedback.lightImpact();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.white.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => AppTheme.tealGradient.createShader(bounds),
                child: Text(
                  'Seelai',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your AI Assistant',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildIconButton(
                icon: isDark ? Icons.light_mode : Icons.dark_mode,
                onTap: widget.onThemeToggle,
                isDark: isDark,
              ),
              const SizedBox(width: 12),
              _buildIconButton(
                icon: Icons.notifications_outlined,
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                  );
                },
                isDark: isDark,
                showBadge: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    bool showBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
              ),
            ),
            child: Icon(
              icon,
              color: isDark ? AppTheme.tealAccent : AppTheme.blueAccent,
              size: 24,
            ),
          ),
          if (showBadge)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.redAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.redAccent.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
