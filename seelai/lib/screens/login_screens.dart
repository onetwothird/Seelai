import 'package:flutter/material.dart';
import 'package:seelai/themes/constants.dart';
import 'package:seelai/themes/widgets.dart';
import 'package:seelai/screens/signup_screen.dart';
import 'package:seelai/mobile/auth_service.dart';
import 'package:seelai/mobile/database_service.dart';
import 'package:seelai/mobile/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  String _selectedRole = 'visually_impaired';
  bool _obscurePassword = true;
  bool _isLoading = false;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _floatController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic));

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
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

          // Background decorative images
          Positioned(
            top: -90,
            left: -30,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/images/bg_shape_3.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: -60,
            right: -60,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/images/bg_shape_1.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.07),

                        // Header
                        ShaderMask(
                          shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                          child: Text(
                            "Welcome Back",
                            style: h1.copyWith(
                              fontSize: screenWidth * 0.095,
                              color: white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          "Sign in to continue your journey",
                          style: body.copyWith(
                            fontSize: screenWidth * 0.044,
                            color: grey,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Role Selection
                        Text(
                          "Select Your Role",
                          style: bodyBold.copyWith(
                            fontSize: screenWidth * 0.042,
                            color: black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),

                        // Role Cards
                        Row(
                          children: [
                            Expanded(
                              child: _buildRoleCard(
                                role: 'visually_impaired',
                                icon: Icons.remove_red_eye_rounded,
                                label: 'User',
                                screenWidth: screenWidth,
                              ),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: _buildRoleCard(
                                role: 'caretaker',
                                icon: Icons.favorite_rounded,
                                label: 'Caretaker',
                                screenWidth: screenWidth,
                              ),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: _buildRoleCard(
                                role: 'admin',
                                icon: Icons.admin_panel_settings_rounded,
                                label: 'MSDWD',
                                screenWidth: screenWidth,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.045),

                        // Email Field
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: softShadow,
                            borderRadius: BorderRadius.circular(radiusLarge),
                          ),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !_isLoading,
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
                                color: greyLight.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(14),
                                child: Icon(
                                  Icons.email_rounded,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusLarge),
                                borderSide: BorderSide(color: greyLighter, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusLarge),
                                borderSide: BorderSide(color: greyLighter, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusLarge),
                                borderSide: BorderSide(color: primary, width: 2.5),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        // Password Field
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: softShadow,
                            borderRadius: BorderRadius.circular(radiusLarge),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            enabled: !_isLoading,
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
                                color: greyLight.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(14),
                                child: Icon(
                                  Icons.lock_rounded,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: greyLight,
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusLarge),
                                borderSide: BorderSide(color: greyLighter, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusLarge),
                                borderSide: BorderSide(color: greyLighter, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusLarge),
                                borderSide: BorderSide(color: primary, width: 2.5),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _isLoading ? null : () {
                              _showForgotPasswordDialog();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            ),
                            child: Text(
                              "Forgot password?",
                              style: bodyBold.copyWith(
                                fontSize: screenWidth * 0.04,
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.035),

                        // Login Button
                        CustomButton(
                          text: "Sign In",
                          onPressed: _isLoading ? null : _handleLogin,
                          isLarge: true,
                        ),

                        SizedBox(height: screenHeight * 0.035),

                        // Create account text
                        Center(
                          child: TextButton(
                            onPressed: _isLoading ? null : () {
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
                                style: body.copyWith(fontSize: screenWidth * 0.042),
                                children: [
                                  TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                    text: "Sign Up",
                                    style: bodyBold.copyWith(
                                      fontSize: screenWidth * 0.042,
                                      color: primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.035),

                        // Divider with text
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      greyLighter,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                "Or continue with",
                                style: caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: greyLight,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      greyLighter,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.035),

                        // Social buttons
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

                        SizedBox(height: screenHeight * 0.06),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Loading Overlay
          if (_isLoading)
            LoadingOverlay(
              message: 'Signing In',
              isVisible: _isLoading,
            ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String label,
    required double screenWidth,
  }) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: _isLoading ? null : () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        decoration: BoxDecoration(
          gradient: isSelected 
              ? primaryGradient 
              : LinearGradient(colors: [white, white]),
          borderRadius: BorderRadius.circular(radiusLarge),
          border: Border.all(
            color: isSelected ? primary.withOpacity(0.3) : greyLighter,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withOpacity(0.35),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: secondary.withOpacity(0.2),
                    blurRadius: 30,
                    offset: Offset(0, 12),
                    spreadRadius: -4,
                  ),
                ]
              : softShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? white : primary,
              size: 30,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: caption.copyWith(
                fontSize: screenWidth * 0.034,
                color: isSelected ? white : black,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, Color brandColor) {
    return GestureDetector(
      onTap: _isLoading ? null : () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Social login coming soon!'),
            backgroundColor: primary,
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        height: 68,
        width: 100,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(radiusLarge),
          border: Border.all(
            color: greyLighter,
            width: 1.5,
          ),
          boxShadow: softShadow,
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 36,
            height: 36,
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final TextEditingController emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Password'),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter your email'),
                    backgroundColor: error,
                  ),
                );
                return;
              }
              
              try {
                await authService.value.sendPasswordResetEmail(
                  email: emailController.text.trim(),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password reset email sent!'),
                    backgroundColor: success,
                  ),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${e.toString()}'),
                    backgroundColor: error,
                  ),
                );
              }
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    // Validate fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: error,
        ),
      );
      return;
    }

    // Basic email validation
    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in with Firebase
      UserCredential userCredential = await authService.value.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Verify user exists in database
      Map<String, dynamic>? userData = await databaseService.getUserData(userCredential.user!.uid);
      
      if (userData != null) {
        // Verify role matches
        String userRole = userData['role'] ?? '';
        
        // Log login activity
        await databaseService.logActivity(
          userId: userCredential.user!.uid,
          action: 'login',
          details: 'User logged in as $userRole',
        );
        
        debugPrint('Logged in as: $userRole');
        debugPrint('Selected role: $_selectedRole');
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome back! Role: $userRole'),
              backgroundColor: success,
            ),
          );
        }
      }
      
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later';
          break;
        default:
          errorMessage = e.message ?? 'Login failed';
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}