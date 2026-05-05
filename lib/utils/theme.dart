import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── PALETTE ──────────────────────────────────────────────────────────────
  // Soft lavender + cream — calm, gentle, and closer to the reference look
  static const Color primaryColor    = Color(0xFF8B7CCB); // Soft lavender
  static const Color primaryLight    = Color(0xFFB7ACE9); // Light lilac
  static const Color accentColor     = Color(0xFFDCD4FF); // Pale lilac
  static const Color accentWarm      = Color(0xFFF0D8CF); // Soft blush

  static const Color lightBackground = Color(0xFFF8F4EA); // Warm cream
  static const Color surfaceColor    = Color(0xFFFFFFFF);
  static const Color cardColor       = Color(0xFFFAF7F0); // Cream card bg

  static const Color textDark        = Color(0xFF2A223D); // Deep plum ink
  static const Color textMedium      = Color(0xFF5D5673); // Muted plum-gray
  static const Color textLight       = Color(0xFF8B849A); // Soft lilac gray

  static const Color errorColor      = Color(0xFFC85B5B); // Gentle coral red
  static const Color successColor    = Color(0xFF3D9E70); // Calm green
  static const Color warningColor    = Color(0xFFE6A85A); // Soft amber

  // ─── GRADIENTS ────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7E68D8), Color(0xFF9A8ED7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF8A73E5), Color(0xFF7E68D8), Color(0xFFB8AAEE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softGradient = LinearGradient(
    colors: [Color(0xFFFDF9F2), Color(0xFFF6EFE4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── SHADOWS ──────────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primaryColor.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: primaryColor.withOpacity(0.35),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get panicShadow => [
    BoxShadow(
      color: errorColor.withOpacity(0.40),
      blurRadius: 28,
      offset: const Offset(0, 12),
      spreadRadius: 2,
    ),
  ];

  // ─── BORDER RADIUS ────────────────────────────────────────────────────────
  static const double radiusSmall  = 8.0;
  static const double radiusMedium = 14.0;
  static const double radiusLarge  = 20.0;
  static const double radiusXL     = 28.0;

  // ─── THEME ────────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        background: lightBackground,
        surface: surfaceColor,
        error: errorColor,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      // ── AppBar ──────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ── Elevated Button ─────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),

      // ── Text Button ─────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Input Decoration ────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: Color(0xFFE8D5E5), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: Color(0xFFE8D5E5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorColor, width: 1.5),
        ),
        labelStyle: GoogleFonts.poppins(
          color: textLight,
          fontSize: 14,
        ),
        hintStyle: GoogleFonts.poppins(
          color: textLight,
          fontSize: 14,
        ),
      ),

      // ── Card ────────────────────────────────────────────────────
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),

      // ── Bottom Navigation ────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Chip ────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: cardColor,
        selectedColor: primaryColor,
        labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),

      // ── Dialog ──────────────────────────────────────────────────
      dialogTheme: DialogTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXL),
        ),
        titleTextStyle: GoogleFonts.poppins(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: GoogleFonts.poppins(
          color: textMedium,
          fontSize: 14,
          height: 1.6,
        ),
      ),

      // ── Snack Bar ───────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textDark,
        contentTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ── Text Theme ──────────────────────────────────────────────
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          color: textDark,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.poppins(
          color: textDark,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: GoogleFonts.poppins(
          color: textDark,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: GoogleFonts.poppins(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: GoogleFonts.poppins(
          color: textDark,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
        titleMedium: GoogleFonts.poppins(
          color: textDark,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: GoogleFonts.poppins(
          color: textMedium,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: textMedium,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: textMedium,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.poppins(
          color: textLight,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.poppins(
          color: textDark,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        labelSmall: GoogleFonts.poppins(
          color: textLight,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ─── HELPER WIDGETS ───────────────────────────────────────────────────────

  /// Rounded gradient container untuk header halaman
  static Widget gradientHeader({
    required Widget child,
    double borderRadius = radiusXL,
    EdgeInsets padding = const EdgeInsets.all(24),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        gradient: headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  /// Card standar dengan shadow lembut
  static Widget card({
    required Widget child,
    EdgeInsets? padding,
    double? borderRadius,
    Color? color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color ?? surfaceColor,
          borderRadius: BorderRadius.circular(borderRadius ?? radiusLarge),
          boxShadow: cardShadow,
        ),
        child: child,
      ),
    );
  }

  /// Badge kategori artikel
  static Widget categoryBadge(String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? primaryColor).withOpacity(0.12),
        borderRadius: BorderRadius.circular(radiusSmall),
        border: Border.all(
          color: (color ?? primaryColor).withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: color ?? primaryColor,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
