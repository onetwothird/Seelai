import 'package:flutter/material.dart';
import 'package:seelai/themes/constants.dart';
import 'package:seelai/themes/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
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

          // Background decorative images - FIXED POSITIONING
          // Top Left - bg_shape_1.png
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: 0.25,
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
            right: 0,
            child: Opacity(
              opacity: 0.2,
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

          // Animated floating circles
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth * 0.08,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_floatAnimation.value),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [secondary.withOpacity(0.3), primary.withOpacity(0.3)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: secondary.withOpacity(0.2),
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
                        SizedBox(height: screenHeight * 0.05),

                        // App icon
                        Container(
                          padding: EdgeInsets.all(18),
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
                            width: 45,
                            height: 45,
                            color: white,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        // Header
                        ShaderMask(
                          shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                          child: Text(
                            "Create Account",
                            style: h1.copyWith(
                              fontSize: screenWidth * 0.09,
                              color: white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Start your journey with us today",
                          style: body.copyWith(
                            fontSize: screenWidth * 0.042,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: screenHeight * 0.04),

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
                              hintText: 'Full Name',
                              hintStyle: body.copyWith(
                                color: grey.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.person_outline,
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
                              hintText: 'Confirm Password',
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

                        SizedBox(height: screenHeight * 0.035),

                        // Register Button
                        CustomButton(
                          text: "Sign Up",
                          onPressed: () {},
                          isLarge: true,
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        // Already have account
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: body.copyWith(fontSize: screenWidth * 0.04),
                                children: [
                                  TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                    text: "Sign In",
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

                        SizedBox(height: screenHeight * 0.025),

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

                        SizedBox(height: screenHeight * 0.025),

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