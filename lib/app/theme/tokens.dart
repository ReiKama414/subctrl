import 'package:flutter/material.dart';

class AppSpacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

class AppRadius {
  static const r2 = 2.0;
  static const r4 = 4.0;
  static const r6 = 6.0;
  static const r8 = 8.0;
  static const r12 = 12.0;
  static const r16 = 16.0;
}

class AppBlur {
  static const none = 0.0;
  static const low = 8.0;
  static const medium = 16.0;
}

class AppMotion {
  static const fast = Duration(milliseconds: 120);
  static const normal = Duration(milliseconds: 180);
  static const slow = Duration(milliseconds: 240);
}

class AppElevation {
  static const none = 0.0;
  static const low = 2.0;
  static const overlay = 8.0;
}

class AppTypography {
  static const sans = TextStyle(
    fontFamily: 'Roboto',
    fontFamilyFallback: ['SF Pro Text', 'Segoe UI', 'Noto Sans', 'sans-serif'],
    height: 1.35,
  );

  static const mono = TextStyle(
    fontFamily: 'Consolas',
    fontFamilyFallback: ['Menlo', 'Courier New', 'monospace'],
    fontFeatures: [FontFeature.tabularFigures()],
    height: 1.2,
  );

  static TextStyle label([Color? color]) => sans.copyWith(
        fontSize: 11,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle body([Color? color]) => sans.copyWith(fontSize: 14, color: color);

  static TextStyle title([Color? color]) => sans.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: color,
      );

  static TextStyle display(Color color, {double size = 32}) => mono.copyWith(
        fontSize: size,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.6,
        color: color,
      );
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceHigh,
    required this.border,
    required this.accent,
    required this.onAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.warning,
    required this.danger,
    required this.success,
    required this.glow,
    required this.chartGrid,
    required this.chartPrimary,
    required this.chartSecondary,
    required this.chartWarning,
    required this.glassFill,
  });

  final Color background;
  final Color surface;
  final Color surfaceHigh;
  final Color border;
  final Color accent;
  final Color onAccent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color warning;
  final Color danger;
  final Color success;
  final Color glow;
  final Color chartGrid;
  final Color chartPrimary;
  final Color chartSecondary;
  final Color chartWarning;
  final Color glassFill;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceHigh,
    Color? border,
    Color? accent,
    Color? onAccent,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? warning,
    Color? danger,
    Color? success,
    Color? glow,
    Color? chartGrid,
    Color? chartPrimary,
    Color? chartSecondary,
    Color? chartWarning,
    Color? glassFill,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      success: success ?? this.success,
      glow: glow ?? this.glow,
      chartGrid: chartGrid ?? this.chartGrid,
      chartPrimary: chartPrimary ?? this.chartPrimary,
      chartSecondary: chartSecondary ?? this.chartSecondary,
      chartWarning: chartWarning ?? this.chartWarning,
      glassFill: glassFill ?? this.glassFill,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      success: Color.lerp(success, other.success, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      chartGrid: Color.lerp(chartGrid, other.chartGrid, t)!,
      chartPrimary: Color.lerp(chartPrimary, other.chartPrimary, t)!,
      chartSecondary: Color.lerp(chartSecondary, other.chartSecondary, t)!,
      chartWarning: Color.lerp(chartWarning, other.chartWarning, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
    );
  }
}

@immutable
class AppChartTheme extends ThemeExtension<AppChartTheme> {
  const AppChartTheme({
    required this.strokeWidth,
    required this.dotRadius,
    required this.gridOpacity,
  });

  final double strokeWidth;
  final double dotRadius;
  final double gridOpacity;

  @override
  AppChartTheme copyWith({double? strokeWidth, double? dotRadius, double? gridOpacity}) {
    return AppChartTheme(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      dotRadius: dotRadius ?? this.dotRadius,
      gridOpacity: gridOpacity ?? this.gridOpacity,
    );
  }

  @override
  AppChartTheme lerp(ThemeExtension<AppChartTheme>? other, double t) {
    if (other is! AppChartTheme) return this;
    return AppChartTheme(
      strokeWidth: lerpDouble(strokeWidth, other.strokeWidth, t)!,
      dotRadius: lerpDouble(dotRadius, other.dotRadius, t)!,
      gridOpacity: lerpDouble(gridOpacity, other.gridOpacity, t)!,
    );
  }
}

double? lerpDouble(double a, double b, double t) => a + (b - a) * t;

extension ThemeX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppChartTheme get chartTheme => Theme.of(this).extension<AppChartTheme>()!;
}
