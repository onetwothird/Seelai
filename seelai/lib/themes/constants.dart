import 'package:flutter/material.dart';

// Modern color palette with depth
const primary = Color(0xFF6366F1); // Indigo
const primaryDark = Color(0xFF4F46E5);
const secondary = Color(0xFF8B5CF6); // Purple
const accent = Color(0xFF06B6D4); // Cyan
const lightBlue = Color(0xFFF0F4FF);
const white = Colors.white;
const black = Color(0xFF0F172A); // Slate black
const grey = Color(0xFF64748B);
const lightGrey = Color(0xFFF8FAFC);
const success = Color(0xFF10B981);
const error = Color(0xFFEF4444);

// Gradients
const primaryGradient = LinearGradient(
  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const accentGradient = LinearGradient(
  colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Typography - Modern & clean
const h1 = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w800,
  color: black,
  letterSpacing: -0.5,
  height: 1.2,
);

const h2 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: black,
  letterSpacing: -0.3,
  height: 1.3,
);

const h3 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: black,
  letterSpacing: -0.2,
);

const body = TextStyle(
  fontSize: 15,
  color: grey,
  height: 1.6,
  fontWeight: FontWeight.w400,
);

const bodyBold = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: grey,
  height: 1.6,
);

const caption = TextStyle(
  fontSize: 13,
  color: grey,
  fontWeight: FontWeight.w500,
);

// Shadows
const softShadow = [
  BoxShadow(
    color: Color(0x1A6366F1),
    blurRadius: 24,
    offset: Offset(0, 8),
    spreadRadius: -4,
  ),
];

const mediumShadow = [
  BoxShadow(
    color: Color(0x266366F1),
    blurRadius: 32,
    offset: Offset(0, 12),
    spreadRadius: -6,
  ),
];

const glowShadow = [
  BoxShadow(
    color: Color(0x336366F1),
    blurRadius: 40,
    offset: Offset(0, 0),
    spreadRadius: 0,
  ),
];