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
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _floatController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
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
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF0F4FF),
                  Color(0xFFFFF0F8),
                  Color(0xFFF0F9FF),
                ],
              ),
            ),
          ),

          // Background decorative images - FIXED POSITIONING
          // Top Left - bg_shape_1.png
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/bg_shape_1.png',
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Top Right - bg_shape_2.png
          Positioned(
            top: 0,
            right: 2,
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'assets/images/bg_shape_2.png',
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Bottom Left - bg_shape_3.png
          Positioned(
            bottom: 0,
            left: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/bg_shape_3.png',
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Bottom Right - bg_shape_4.png
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/bg_shape_4.png',
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Animated decorative circles
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth * 0.1,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [primary.withOpacity(0.3), secondary.withOpacity(0.3)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.3,
            right: screenWidth * 0.15,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_floatAnimation.value),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [accent.withOpacity(0.3), Color(0xFF3B82F6).withOpacity(0.3)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.2),
                          blurRadius: 25,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),

                  // Logo with scale animation and floating effect
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value * 0.5),
                            child: Container(
                              height: screenHeight * 0.4,
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Outer glow circle
                                    Container(
                                      padding: EdgeInsets.all(50),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            primary.withOpacity(0.15),
                                            secondary.withOpacity(0.15),
                                            accent.withOpacity(0.15),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primary.withOpacity(0.3),
                                            blurRadius: 60,
                                            offset: Offset(0, 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Main logo circle with app icon
                                    Container(
                                      padding: EdgeInsets.all(35),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [primary, secondary],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primary.withOpacity(0.5),
                                            blurRadius: 40,
                                            offset: Offset(0, 15),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/icons/logo.png', 
                                        width: screenWidth * 0.25,
                                        height: screenWidth * 0.25,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Welcome text with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                      child: Text(
                        'Welcome to Seelai',
                        style: h1.copyWith(
                          fontSize: screenWidth * 0.09,
                          color: white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // Description with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      "Your vision, our mission. Experience care that truly sees you.",
                      style: body.copyWith(
                        fontSize: screenWidth * 0.042,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Spacer(),

                  // Buttons with enhanced styling
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

                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}