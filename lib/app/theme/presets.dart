import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';

class ThemeTokens {
  const ThemeTokens({
    required this.preset,
    required this.colors,
    required this.glowIntensity,
    required this.blur,
    required this.radius,
    required this.chart,
    required this.brightness,
  });

  final ThemePreset preset;
  final AppColors colors;
  final double glowIntensity;
  final double blur;
  final double radius;
  final AppChartTheme chart;
  final Brightness brightness;

  ThemeTokens copyWith({
    ThemePreset? preset,
    AppColors? colors,
    double? glowIntensity,
    double? blur,
    double? radius,
    AppChartTheme? chart,
    Brightness? brightness,
  }) {
    return ThemeTokens(
      preset: preset ?? this.preset,
      colors: colors ?? this.colors,
      glowIntensity: glowIntensity ?? this.glowIntensity,
      blur: blur ?? this.blur,
      radius: radius ?? this.radius,
      chart: chart ?? this.chart,
      brightness: brightness ?? this.brightness,
    );
  }

  Map<String, dynamic> toJson() => {
        'preset': preset.name,
        'glowIntensity': glowIntensity,
        'blur': blur,
        'radius': radius,
        'brightness': brightness.name,
        'accent': colors.accent.toARGB32(),
        'background': colors.background.toARGB32(),
        'surface': colors.surface.toARGB32(),
        'border': colors.border.toARGB32(),
      };

  static ThemeTokens fromCustomJson(Map<String, dynamic> json, ThemeTokens fallback) {
    Color c(String key, Color d) {
      final v = json[key];
      if (v is int) return Color(v);
      return d;
    }

    final colors = fallback.colors.copyWith(
      accent: c('accent', fallback.colors.accent),
      background: c('background', fallback.colors.background),
      surface: c('surface', fallback.colors.surface),
      border: c('border', fallback.colors.border),
      chartPrimary: c('accent', fallback.colors.accent),
    );
    return fallback.copyWith(
      preset: ThemePreset.custom,
      colors: colors,
      glowIntensity: (json['glowIntensity'] as num?)?.toDouble() ?? fallback.glowIntensity,
      blur: (json['blur'] as num?)?.toDouble() ?? fallback.blur,
      radius: (json['radius'] as num?)?.toDouble() ?? fallback.radius,
    );
  }
}

class ThemePresets {
  static const chart = AppChartTheme(strokeWidth: 1.4, dotRadius: 3, gridOpacity: 0.18);

  static final voidTheme = ThemeTokens(
    preset: ThemePreset.voidTheme,
    brightness: Brightness.dark,
    glowIntensity: 0.18,
    blur: AppBlur.low,
    radius: AppRadius.r6,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF0B0C0E),
      surface: Color(0xFF14161A),
      surfaceHigh: Color(0xFF1C1F24),
      border: Color(0xFF2A2E35),
      accent: Color(0xFF5EEAD4),
      onAccent: Color(0xFF04110E),
      textPrimary: Color(0xFFE8E6E1),
      textSecondary: Color(0xFFA7A9AD),
      textMuted: Color(0xFF6D7178),
      warning: Color(0xFFD4A017),
      danger: Color(0xFFC45C4A),
      success: Color(0xFF5EEAD4),
      glow: Color(0x335EEAD4),
      chartGrid: Color(0xFF2A2E35),
      chartPrimary: Color(0xFF5EEAD4),
      chartSecondary: Color(0xFFA7A9AD),
      chartWarning: Color(0xFFD4A017),
      glassFill: Color(0xCC14161A),
    ),
  );

  static final terminal = ThemeTokens(
    preset: ThemePreset.terminal,
    brightness: Brightness.dark,
    glowIntensity: 0.22,
    blur: AppBlur.low,
    radius: AppRadius.r4,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF050805),
      surface: Color(0xFF0C120C),
      surfaceHigh: Color(0xFF141C14),
      border: Color(0xFF1E2A1E),
      accent: Color(0xFF7CFF7C),
      onAccent: Color(0xFF031003),
      textPrimary: Color(0xFFC8F0C8),
      textSecondary: Color(0xFF7AAA7A),
      textMuted: Color(0xFF4E6A4E),
      warning: Color(0xFFC8C85A),
      danger: Color(0xFFD07070),
      success: Color(0xFF7CFF7C),
      glow: Color(0x337CFF7C),
      chartGrid: Color(0xFF1E2A1E),
      chartPrimary: Color(0xFF7CFF7C),
      chartSecondary: Color(0xFF7AAA7A),
      chartWarning: Color(0xFFC8C85A),
      glassFill: Color(0xCC0C120C),
    ),
  );

  static final akira = ThemeTokens(
    preset: ThemePreset.akira,
    brightness: Brightness.dark,
    glowIntensity: 0.16,
    blur: AppBlur.low,
    radius: AppRadius.r6,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF0A0A0A),
      surface: Color(0xFF161616),
      surfaceHigh: Color(0xFF1F1F1F),
      border: Color(0xFF2C2C2C),
      accent: Color(0xFFE11D2A),
      onAccent: Color(0xFFF4F0EA),
      textPrimary: Color(0xFFF4F0EA),
      textSecondary: Color(0xFFB4B0AA),
      textMuted: Color(0xFF7A7772),
      warning: Color(0xFFD4A017),
      danger: Color(0xFFE11D2A),
      success: Color(0xFF8AA07A),
      glow: Color(0x33E11D2A),
      chartGrid: Color(0xFF2C2C2C),
      chartPrimary: Color(0xFFE11D2A),
      chartSecondary: Color(0xFFF4F0EA),
      chartWarning: Color(0xFFD4A017),
      glassFill: Color(0xCC161616),
    ),
  );

  static final ice = ThemeTokens(
    preset: ThemePreset.ice,
    brightness: Brightness.dark,
    glowIntensity: 0.14,
    blur: AppBlur.low,
    radius: AppRadius.r8,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF081018),
      surface: Color(0xFF101820),
      surfaceHigh: Color(0xFF182028),
      border: Color(0xFF2A3640),
      accent: Color(0xFF8EC8E0),
      onAccent: Color(0xFF071018),
      textPrimary: Color(0xFFE4EEF4),
      textSecondary: Color(0xFF9AADB8),
      textMuted: Color(0xFF6A7C88),
      warning: Color(0xFFD4B46A),
      danger: Color(0xFFC07070),
      success: Color(0xFF8EC8E0),
      glow: Color(0x338EC8E0),
      chartGrid: Color(0xFF2A3640),
      chartPrimary: Color(0xFF8EC8E0),
      chartSecondary: Color(0xFF9AADB8),
      chartWarning: Color(0xFFD4B46A),
      glassFill: Color(0xCC101820),
    ),
  );

  static final light = ThemeTokens(
    preset: ThemePreset.light,
    brightness: Brightness.light,
    glowIntensity: 0.06,
    blur: AppBlur.low,
    radius: AppRadius.r8,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFFF3EFEA),
      surface: Color(0xFFFAF7F2),
      surfaceHigh: Color(0xFFFFFFFF),
      border: Color(0xFFD8D2CA),
      accent: Color(0xFF1C1C1C),
      onAccent: Color(0xFFFAF7F2),
      textPrimary: Color(0xFF161616),
      textSecondary: Color(0xFF5C5A56),
      textMuted: Color(0xFF8A8680),
      warning: Color(0xFFA07816),
      danger: Color(0xFFB04034),
      success: Color(0xFF2F6B52),
      glow: Color(0x221C1C1C),
      chartGrid: Color(0xFFD8D2CA),
      chartPrimary: Color(0xFF1C1C1C),
      chartSecondary: Color(0xFF5C5A56),
      chartWarning: Color(0xFFA07816),
      glassFill: Color(0xCCFAF7F2),
    ),
  );

  static ThemeTokens byPreset(ThemePreset preset) => switch (preset) {
        ThemePreset.voidTheme => voidTheme,
        ThemePreset.terminal => terminal,
        ThemePreset.akira => akira,
        ThemePreset.ice => ice,
        ThemePreset.light => light,
        ThemePreset.custom => voidTheme.copyWith(preset: ThemePreset.custom),
      };
}
