import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static const r20 = 20.0;
  static const r24 = 24.0;
  static const pill = 999.0;
}

/// Vivid swatches for service avatars, categories and charts.
/// Mid-light tones so dark foreground text stays readable on every preset.
class AppPalette {
  static const onSwatch = Color(0xFF111217);

  static const swatches = [
    Color(0xFF8B9CFF),
    Color(0xFFFF9F7A),
    Color(0xFF5FD9B4),
    Color(0xFFFFD166),
    Color(0xFFE79BE8),
    Color(0xFF6CC8F0),
    Color(0xFFB4E07F),
    Color(0xFFFF8FA8),
  ];

  static Color forKey(String key) {
    var h = 0;
    for (final unit in key.toLowerCase().codeUnits) {
      h = (h * 31 + unit) & 0x7fffffff;
    }
    return swatches[h % swatches.length];
  }

  static Color category(String slug) => switch (slug) {
        'ai' => swatches[0],
        'video' => swatches[7],
        'music' => swatches[2],
        'gaming' => swatches[4],
        'delivery' => swatches[1],
        'software' => swatches[5],
        'cloud' => const Color(0xFF9FC3FF),
        'social' => const Color(0xFFFFB37A),
        'dating' => const Color(0xFFFF8FA8),
        'shopping' => swatches[3],
        'education' => swatches[6],
        'fitness' => const Color(0xFF5FD9B4),
        'vpn' => const Color(0xFF7FE0D0),
        'news' => const Color(0xFFD1C4A8),
        'developer' => const Color(0xFFC3A6FF),
        _ => const Color(0xFFB8BCC6),
      };

  static IconData categoryIcon(String slug) => switch (slug) {
        'ai' => Icons.auto_awesome_rounded,
        'video' => Icons.play_circle_rounded,
        'music' => Icons.music_note_rounded,
        'gaming' => Icons.sports_esports_rounded,
        'delivery' => Icons.delivery_dining_rounded,
        'software' => Icons.apps_rounded,
        'cloud' => Icons.cloud_rounded,
        'social' => Icons.forum_rounded,
        'dating' => Icons.favorite_rounded,
        'shopping' => Icons.shopping_bag_rounded,
        'education' => Icons.school_rounded,
        'fitness' => Icons.fitness_center_rounded,
        'vpn' => Icons.vpn_lock_rounded,
        'news' => Icons.newspaper_rounded,
        'developer' => Icons.code_rounded,
        _ => Icons.category_rounded,
      };
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
  /// Noto Sans TC covers CJK on Flutter web (CanvasKit can't use system fonts).
  static TextStyle get sans => GoogleFonts.notoSansTc(height: 1.35);

  static TextStyle get mono => GoogleFonts.robotoMono(
        height: 1.2,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle label([Color? color]) => sans.copyWith(
        fontSize: 12,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle caption([Color? color]) => sans.copyWith(fontSize: 12, color: color);

  static TextStyle body([Color? color]) => sans.copyWith(fontSize: 14, color: color);

  static TextStyle title([Color? color]) => sans.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
        color: color,
      );

  static TextStyle headline([Color? color]) => sans.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
        height: 1.15,
        color: color,
      );

  static TextStyle amount(Color color, {double size = 16, FontWeight weight = FontWeight.w700}) => sans.copyWith(
        fontSize: size,
        fontWeight: weight,
        fontFeatures: const [FontFeature.tabularFigures()],
        letterSpacing: -0.2,
        height: 1.1,
        color: color,
      );

  static TextStyle display(Color color, {double size = 32}) => amount(color, size: size, weight: FontWeight.w800);

  /// Warm the font cache before the first locale-heavy screen paints.
  static Future<void> preload() => GoogleFonts.pendingFonts([
        GoogleFonts.notoSansTc(),
        GoogleFonts.notoSansTc(fontWeight: FontWeight.w600),
        GoogleFonts.notoSansTc(fontWeight: FontWeight.w700),
        GoogleFonts.notoSansTc(fontWeight: FontWeight.w800),
      ]);
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
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  AppChartTheme get chartTheme => Theme.of(this).extension<AppChartTheme>()!;
}
