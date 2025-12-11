import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF3498DB);
  static const Color secondary = Color(0xFF2ECC71);
  static const Color accent = Color(0xFFE74C3C);

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF5F7FA);

  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textHint = Color(0xFFB2BEC3);

  // Status Colors
  static const Color success = Color(0xFF00B894);
  static const Color error = Color(0xFFFF7675);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color info = Color(0xFF74B9FF);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3498DB), Color(0xFF5DADE2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF3498DB), Color(0xFF2980B9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 20,
    offset: const Offset(0, 4),
  );
}
