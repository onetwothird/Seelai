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

  // Role selection
  String _selectedRole = 'visually_impaired';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // Caretaker-specific
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  // Admin-specific
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
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
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _relationshipController.dispose();
    _phoneController.dispose();
    _employeeIdController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Gradient background (back layer)
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

          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
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

          // 4. Main content (front layer)
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
                        SizedBox(height: screenHeight * 0.05),

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

                        SizedBox(height: screenHeight * 0.03),

                        // Role Selection
                        Text(
                          "I am a...",
                          style: bodyBold.copyWith(
                            fontSize: screenWidth * 0.04,
                            color: black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Role Cards
                        Row(
                          children: [
                            Expanded(
                              child: _buildRoleCard(
                                role: 'visually_impaired',
                                icon: Icons.remove_red_eye_outlined,
                                label: 'User',
                                screenWidth: screenWidth,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildRoleCard(
                                role: 'caretaker',
                                icon: Icons.favorite_outline,
                                label: 'Caretaker',
                                screenWidth: screenWidth,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildRoleCard(
                                role: 'admin',
                                icon: Icons.admin_panel_settings_outlined,
                                label: 'MSDWD',
                                screenWidth: screenWidth,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Common Fields
                        _buildTextField(
                          controller: _nameController,
                          hint: 'Full Name',
                          icon: Icons.person_outline,
                          screenHeight: screenHeight,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        _buildTextField(
                          controller: _ageController,
                          hint: 'Age',
                          icon: Icons.cake_outlined,
                          keyboardType: TextInputType.number,
                          screenHeight: screenHeight,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        _buildTextField(
                          controller: _emailController,
                          hint: 'Email address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          screenHeight: screenHeight,
                        ),

                        // Role-specific fields
                        if (_selectedRole == 'caretaker') ...[
                          SizedBox(height: screenHeight * 0.02),
                          _buildTextField(
                            controller: _phoneController,
                            hint: 'Phone Number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            screenHeight: screenHeight,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildTextField(
                            controller: _relationshipController,
                            hint: 'Relationship to Patient',
                            icon: Icons.people_outline,
                            screenHeight: screenHeight,
                          ),
                        ],

                        if (_selectedRole == 'admin') ...[
                          SizedBox(height: screenHeight * 0.02),
                          _buildTextField(
                            controller: _employeeIdController,
                            hint: 'Employee ID',
                            icon: Icons.badge_outlined,
                            screenHeight: screenHeight,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildTextField(
                            controller: _departmentController,
                            hint: 'Department',
                            icon: Icons.business_outlined,
                            screenHeight: screenHeight,
                          ),
                        ],

                        SizedBox(height: screenHeight * 0.02),

                        // Password Field
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: softShadow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
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
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: grey,
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: lightBlue, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: lightBlue, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: primary, width: 2),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        // Confirm Password Field
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: softShadow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
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
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: grey,
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: lightBlue, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: lightBlue, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: primary, width: 2),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.035),

                        // Register Button
                        CustomButton(
                          text: "Sign Up",
                          onPressed: _handleSignup,
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: body.copyWith(fontSize: screenWidth * 0.04),
                                children: [
                                  const TextSpan(text: "Already have an account? "),
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
                              padding: const EdgeInsets.symmetric(horizontal: 16),
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

                        // Social buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              'assets/icons/facebook.png',
                              const Color(0xFF1877F2),
                            ),
                            const SizedBox(width: 16),
                            _buildSocialButton(
                              'assets/icons/google.png',
                              const Color(0xFFDB4437),
                            ),
                            const SizedBox(width: 16),
                            _buildSocialButton(
                              'assets/icons/instagram.png',
                              const Color(0xFFE4405F),
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

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String label,
    required double screenWidth,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary : white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primary : lightBlue,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
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
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: caption.copyWith(
                fontSize: screenWidth * 0.032,
                color: isSelected ? white : black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double screenHeight,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: softShadow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: body.copyWith(
          fontSize: 16,
          color: black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: white,
          filled: true,
          hintText: hint,
          hintStyle: body.copyWith(
            color: grey.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: primary,
              size: 24,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: lightBlue, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: lightBlue, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, Color brandColor) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement social signup
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.image_not_supported_outlined,
              color: grey,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignup() {
    // Validate fields
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Role-specific validation
    if (_selectedRole == 'caretaker') {
      if (_phoneController.text.isEmpty || _relationshipController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all caretaker information')),
        );
        return;
      }
    }

    if (_selectedRole == 'admin') {
      if (_employeeIdController.text.isEmpty || _departmentController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all admin information')),
        );
        return;
      }
    }

    // TODO: Implement signup logic
    debugPrint('Signing up as: $_selectedRole');
    debugPrint('Name: ${_nameController.text}');
    debugPrint('Age: ${_ageController.text}');
    debugPrint('Email: ${_emailController.text}');
    
    if (_selectedRole == 'caretaker') {
      debugPrint('Phone: ${_phoneController.text}');
      debugPrint('Relationship: ${_relationshipController.text}');
    }
    
    if (_selectedRole == 'admin') {
      debugPrint('Employee ID: ${_employeeIdController.text}');
      debugPrint('Department: ${_departmentController.text}');
    }

    // Navigate to appropriate screen after successful signup
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerificationScreen()));
  }
}