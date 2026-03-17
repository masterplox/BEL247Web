import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - BEL247 Brand Colors
  static const Color primary = Color(0xFF148A2E); // New green
  static const Color primaryLight = Color(0xFF4CAF50); // Lighter green
  static const Color primaryDark = Color(0xFF0A681F); // Darker green
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFFC107); // Amber/Yellow
  static const Color secondaryLight = Color(0xFFFFD54F); // Light amber
  static const Color secondaryDark = Color(0xFFFFA000); // Dark amber
  
  // Accent Colors
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color accentLight = Color(0xFFFBBF24); // Light amber
  static const Color accentDark = Color(0xFFD97706); // Dark amber
  
  // Status Colors
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);
  
  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textInverse = Color(0xFFFFFFFF);
  
  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderDark = Color(0xFFD1D5DB);
  
  // TOU Colors
  static const Color peak = Color(0xFFEF4444); // Red
  static const Color midPeak = Color(0xFFF59E0B); // Amber
  static const Color offPeak = Color(0xFF10B981); // Green

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF3B82F6), // Blue
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Purple
    Color(0xFF06B6D4), // Cyan
    Color(0xFF84CC16), // Lime
    Color(0xFFF97316), // Orange
  ];
  
  // Specific chart colors for AMI usage
  static const Color chart2 = Color(0xFFF59E0B); // Amber/Orange for cost
  static const Color chart3 = Color(0xFFFBBF24); // Light amber for mid-peak
  /// Muted slate for “older” year line (contrasts yellow/green without dominating)
  static const Color chartYearOlder = Color(0xFF64748B);
  /// Darker green for emphasis on current-year consumption line
  static const Color chartThisYearConsumption = Color(0xFF047857);
  static const Color chart4 = Color(0xFFEF4444); // Red for peak
  
  // Payment Status Colors
  static const Color paid = Color(0xFF10B981); // Green
  static const Color due = Color(0xFFEF4444); // Red
  static const Color pending = Color(0xFFF59E0B); // Amber
  static const Color overdue = Color(0xFFDC2626);

  static const Color transparent = Colors.transparent;
}
