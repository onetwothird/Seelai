import 'package:flutter/material.dart';
import 'package:seelai/themes/constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.isTransparent = false,
    required this.text,
    this.isLarge = false,
    this.onPressed,
  });

  final bool isTransparent;
  final bool isLarge;
  final String text;
  final void Function()? onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 58,
          width: widget.isLarge ? double.infinity : 160,
          decoration: BoxDecoration(
            gradient: widget.isTransparent ? null : primaryGradient,
            borderRadius: BorderRadius.circular(16),
            border: widget.isTransparent
                ? Border.all(color: primary, width: 2)
                : null,
            boxShadow: widget.isTransparent || _isPressed ? [] : mediumShadow,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: widget.onPressed,
            child: Text(
              widget.text,
              style: h3.copyWith(
                color: widget.isTransparent ? primary : white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.controller,
  });

  final String hint;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        boxShadow: _isFocused ? mediumShadow : softShadow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        style: body.copyWith(
          fontSize: 16,
          color: black,
          fontWeight: FontWeight.w500,
        ),
        onTap: () => setState(() => _isFocused = true),
        onTapOutside: (_) => setState(() => _isFocused = false),
        decoration: InputDecoration(
          fillColor: white,
          filled: true,
          hintText: widget.hint,
          hintStyle: body.copyWith(
            color: grey.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: grey,
                    size: 22,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : null,
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
    );
  }
}

class SocialButton extends StatefulWidget {
  const SocialButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            boxShadow: _isHovered ? mediumShadow : softShadow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: widget.onPressed,
              onHover: (hovering) => setState(() => _isHovered = hovering),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 60,
                width: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isHovered ? primary.withOpacity(0.3) : lightBlue,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: _isHovered ? primary : grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}