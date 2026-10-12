import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/presets.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';

class AppTheme {
  static ThemeData fromTokens(ThemeTokens tokens, {bool reduceMotion = false}) {
    final c = tokens.colors;
    final radius = BorderRadius.circular(tokens.radius);
    return ThemeData(
      useMaterial3: true,
      brightness: tokens.brightness,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      colorScheme: ColorScheme(
        brightness: tokens.brightness,
        primary: c.accent,
        onPrimary: c.onAccent,
        secondary: c.textSecondary,
        onSecondary: c.background,
        error: c.danger,
        onError: c.textPrimary,
        surface: c.surface,
        onSurface: c.textPrimary,
      ),
      textTheme: TextTheme(
        bodyMedium: AppTypography.body(c.textPrimary),
        bodySmall: AppTypography.body(c.textSecondary).copyWith(fontSize: 12),
        titleMedium: AppTypography.title(c.textPrimary),
        labelSmall: AppTypography.label(c.textMuted),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.label(c.textPrimary).copyWith(fontSize: 12),
      ),
      dividerColor: c.border,
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: c.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceHigh,
        border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: c.border)),
        enabledBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: c.border)),
        focusedBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: c.accent)),
        labelStyle: AppTypography.label(c.textMuted),
        hintStyle: AppTypography.body(c.textMuted),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surfaceHigh,
        selectedColor: c.accent.withValues(alpha: 0.18),
        labelStyle: AppTypography.label(c.textSecondary),
        side: BorderSide(color: c.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r4)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: c.surfaceHigh,
        contentTextStyle: AppTypography.body(c.textPrimary),
        behavior: SnackBarBehavior.floating,
      ),
      pageTransitionsTheme: reduceMotion
          ? const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              },
            )
          : const PageTransitionsTheme(),
      extensions: [c, tokens.chart],
    );
  }

  static BoxConstraints get pageConstraints =>
      const BoxConstraints(maxWidth: AppInfo.maxContentWidth);
}
