import 'package:flutter/material.dart';
import 'package:seelai/themes/constants.dart';
import 'package:seelai/screens/login_screens.dart';
import 'package:seelai/screens/signup_screen.dart';
import 'package:seelai/themes/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1400),
      vsync: this,
    );
    _floatController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _floatAnimation = Tween<double>(begin: -12, end: 12).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Enhanced gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFAF5FF),
                  Color(0xFFFFF1F2),
                  Color(0xFFF0FDFA),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Decorative circles with blur effect
          Positioned(
            top: -100,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primary.withOpacity(0.15),
                    primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            right: -60,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    secondary.withOpacity(0.12),
                    secondary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            top: -150,
            left: -30,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/bg_shape_3.png',
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
         // Background decorative images
          Positioned(
            bottom: -100,
            right: -60,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/bg_shape_1.png',
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),

                  // Logo with enhanced animations
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value * 0.6),
                            child: Container(
                              height: screenHeight * 0.28,
                              padding: EdgeInsets.all(spacingLarge),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    primary.withOpacity(0.08),
                                    Colors.transparent,
                                  ],
                                  stops: [0.5, 1.0],
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary.withOpacity(0.2),
                                      blurRadius: 50,
                                      offset: Offset(0, 20),
                                      spreadRadius: -5,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/icons/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Welcome text with enhanced gradient
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                      child: Text(
                        'Welcome to Seelai',
                        style: h1.copyWith(
                          fontSize: screenWidth * 0.095,
                          color: white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Description with better styling
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spacingMedium),
                      child: Text(
                        "Your vision, our mission.\nExperience care that truly sees you.",
                        style: body.copyWith(
                          fontSize: screenWidth * 0.044,
                          height: 1.7,
                          color: grey,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  Spacer(),

                  // Feature highlights (optional addition)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeaturePill(Icons.accessibility_new_rounded, "Accessible"),
                        SizedBox(width: 12),
                        _buildFeaturePill(Icons.security_rounded, "Secure"),
                        SizedBox(width: 12),
                        _buildFeaturePill(Icons.favorite_rounded, "Caring"),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Buttons with enhanced design
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Login',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: 'Sign Up',
                            isTransparent: true,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.06),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(radiusMedium),
        border: Border.all(color: greyLighter, width: 1),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: primary),
          SizedBox(width: 6),
          Text(
            label,
            style: small.copyWith(
              color: grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}