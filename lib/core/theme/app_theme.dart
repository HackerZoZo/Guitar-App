import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark background
  static const background = Color(0xFF0E1116);
  static const surface = Color(0xFF1A1E24);
  static const surfaceVariant = Color(0xFF252A32);
  
  // Accent - soft teal
  static const primary = Color(0xFF4DD0B5);
  static const primaryDark = Color(0xFF3AB89F);
  static const primaryLight = Color(0xFF6FDDC7);
  
  // Text
  static const textPrimary = Color(0xFFE8E8E8);
  static const textSecondary = Color(0xFFB0B0B0);
  static const textTertiary = Color(0xFF808080);
  
  // Functional
  static const error = Color(0xFFFF6B6B);
  static const success = Color(0xFF51CF66);
  static const warning = Color(0xFFFFD93D);
  
  // Overlays
  static const overlay = Color(0x30FFFFFF);
  static const divider = Color(0x20FFFFFF);
}

class AppTheme {
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.textPrimary,
      ),
      
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: textTheme.displayMedium?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.surfaceVariant,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.2),
        trackHeight: 4,
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primary,
        labelStyle: const TextStyle(color: AppColors.textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
