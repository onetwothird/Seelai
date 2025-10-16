import 'package:flutter/material.dart';
import 'package:seelai/themes/constants.dart';
import 'package:seelai/themes/widgets.dart';
import 'package:seelai/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _floatController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
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

   Positioned(
            bottom:  -40,
            right: -30,
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
          
          // top left - bg_shape_3.png
          Positioned(
            top: -100,
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

          // Animated floating circles
          Positioned(
            top: screenHeight * 0.12,
            right: screenWidth * 0.1,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [accent.withOpacity(0.3), Color(0xFF3B82F6).withOpacity(0.3)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.2),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Scrollable content
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.06),

                        // App icon
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [primary, secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.4),
                                blurRadius: 30,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icons/logo.png',
                            width: 50,
                            height: 50,
                            color: white,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Header
                        ShaderMask(
                          shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                          child: Text(
                            "Welcome Back",
                            style: h1.copyWith(
                              fontSize: screenWidth * 0.09,
                              color: white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Sign in to continue your journey",
                          style: body.copyWith(
                            fontSize: screenWidth * 0.042,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Enhanced Text Fields with icons
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: softShadow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            style: body.copyWith(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              fillColor: white,
                              filled: true,
                              hintText: 'Email address',
                              hintStyle: body.copyWith(
                                color: grey.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: lightBlue, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: lightBlue, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: primary, width: 2),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Container(
                          decoration: BoxDecoration(
                            boxShadow: softShadow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            obscureText: true,
                            style: body.copyWith(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              fillColor: white,
                              filled: true,
                              hintText: 'Password',
                              hintStyle: body.copyWith(
                                color: grey.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.lock_outline,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility_off_outlined,
                                  color: grey,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: lightBlue, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: lightBlue, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: primary, width: 2),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.015),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                            child: Text(
                              "Forgot password?",
                              style: bodyBold.copyWith(
                                fontSize: screenWidth * 0.038,
                                color: primary,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Login Button
                        CustomButton(
                          text: "Sign In",
                          onPressed: () {},
                          isLarge: true,
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Create account text
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: body.copyWith(fontSize: screenWidth * 0.04),
                                children: [
                                  TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                    text: "Sign Up",
                                    style: bodyBold.copyWith(
                                      fontSize: screenWidth * 0.04,
                                      color: primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Divider with text
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      grey.withOpacity(0.3),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Or continue with",
                                style: caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      grey.withOpacity(0.3),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Enhanced Social buttons with actual icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              'assets/icons/facebook.png',
                              Color(0xFF1877F2),
                            ),
                            SizedBox(width: 16),
                            _buildSocialButton(
                              'assets/icons/google.png',
                              Color(0xFFDB4437),
                            ),
                            SizedBox(width: 16),
                            _buildSocialButton(
                              'assets/icons/instagram.png',
                              Color(0xFFE4405F),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, Color brandColor) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 65,
        width: 95,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: lightBlue,
            width: 1.5,
          ),
          boxShadow: softShadow,
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 35,
            height: 35,
          ),
        ),
      ),
    );
  }
}