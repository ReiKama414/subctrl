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

    final accent = c('accent', fallback.colors.accent);
    final background = c('background', fallback.colors.background);
    final surface = c('surface', fallback.colors.surface);
    final border = c('border', fallback.colors.border);
    final brightness = json['brightness'] == 'light' ? Brightness.light : Brightness.dark;
    final onLight = brightness == Brightness.light;
    final colors = fallback.colors.copyWith(
      accent: accent,
      background: background,
      surface: surface,
      border: border,
      surfaceHigh: c('surfaceHigh', onLight ? const Color(0xFFFFFFFF) : fallback.colors.surfaceHigh),
      onAccent: c('onAccent', onLight ? const Color(0xFFFAF7F2) : fallback.colors.onAccent),
      textPrimary: c('textPrimary', onLight ? const Color(0xFF161616) : fallback.colors.textPrimary),
      textSecondary: c('textSecondary', onLight ? const Color(0xFF5C5A56) : fallback.colors.textSecondary),
      textMuted: c('textMuted', onLight ? const Color(0xFF8A8680) : fallback.colors.textMuted),
      chartPrimary: accent,
      glassFill: Color(onLight ? 0xCCFAF7F2 : 0xE617191F),
    );
    return fallback.copyWith(
      preset: ThemePreset.custom,
      brightness: brightness,
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
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF0D0E12),
      surface: Color(0xFF17191F),
      surfaceHigh: Color(0xFF2A2E38),
      border: Color(0xFF3A3F4A),
      accent: Color(0xFF5EEAD4),
      onAccent: Color(0xFF04110E),
      textPrimary: Color(0xFFF0EEE9),
      textSecondary: Color(0xFFC0C2C7),
      textMuted: Color(0xFF8B9099),
      warning: Color(0xFFD4A017),
      danger: Color(0xFFC45C4A),
      success: Color(0xFF5EEAD4),
      glow: Color(0x335EEAD4),
      chartGrid: Color(0xFF3A3F4A),
      chartPrimary: Color(0xFF5EEAD4),
      chartSecondary: Color(0xFFC0C2C7),
      chartWarning: Color(0xFFD4A017),
      glassFill: Color(0xE617191F),
    ),
  );

  static final terminal = ThemeTokens(
    preset: ThemePreset.terminal,
    brightness: Brightness.dark,
    glowIntensity: 0.22,
    blur: AppBlur.low,
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF050805),
      surface: Color(0xFF0C120C),
      surfaceHigh: Color(0xFF1A261A),
      border: Color(0xFF2E3E2E),
      accent: Color(0xFF7CFF7C),
      onAccent: Color(0xFF031003),
      textPrimary: Color(0xFFD4F5D4),
      textSecondary: Color(0xFF9BC89B),
      textMuted: Color(0xFF6E8E6E),
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
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF0A0A0A),
      surface: Color(0xFF161616),
      surfaceHigh: Color(0xFF282828),
      border: Color(0xFF3A3A3A),
      accent: Color(0xFFE11D2A),
      onAccent: Color(0xFFF4F0EA),
      textPrimary: Color(0xFFF4F0EA),
      textSecondary: Color(0xFFC8C4BE),
      textMuted: Color(0xFF96938E),
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
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF081018),
      surface: Color(0xFF101820),
      surfaceHigh: Color(0xFF1E2A34),
      border: Color(0xFF3A4A56),
      accent: Color(0xFF8EC8E0),
      onAccent: Color(0xFF071018),
      textPrimary: Color(0xFFEAF4FA),
      textSecondary: Color(0xFFB0C2CC),
      textMuted: Color(0xFF8496A2),
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
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFFF3EFEA),
      surface: Color(0xFFFAF7F2),
      surfaceHigh: Color(0xFFE8E4DE),
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

  static final noir = ThemeTokens(
    preset: ThemePreset.noir,
    brightness: Brightness.dark,
    glowIntensity: 0.2,
    blur: AppBlur.low,
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFF0A0810),
      surface: Color(0xFF14101C),
      surfaceHigh: Color(0xFF221C2E),
      border: Color(0xFF3D3350),
      accent: Color(0xFFB794F6),
      onAccent: Color(0xFF12081E),
      textPrimary: Color(0xFFF2ECFA),
      textSecondary: Color(0xFFC4B8D4),
      textMuted: Color(0xFF8E82A0),
      warning: Color(0xFFE0B04A),
      danger: Color(0xFFE07090),
      success: Color(0xFF9AE6B4),
      glow: Color(0x33B794F6),
      chartGrid: Color(0xFF2E2640),
      chartPrimary: Color(0xFFB794F6),
      chartSecondary: Color(0xFFC4B8D4),
      chartWarning: Color(0xFFE0B04A),
      glassFill: Color(0xCC14101C),
    ),
  );

  static final sakura = ThemeTokens(
    preset: ThemePreset.sakura,
    brightness: Brightness.light,
    glowIntensity: 0.08,
    blur: AppBlur.low,
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFFFFF5F7),
      surface: Color(0xFFFFFBFC),
      surfaceHigh: Color(0xFFF5E6EA),
      border: Color(0xFFE8C4CF),
      accent: Color(0xFFD4547A),
      onAccent: Color(0xFFFFF5F7),
      textPrimary: Color(0xFF3D2030),
      textSecondary: Color(0xFF6B4558),
      textMuted: Color(0xFF9A7080),
      warning: Color(0xFFC08030),
      danger: Color(0xFFC04050),
      success: Color(0xFF5A9A70),
      glow: Color(0x22D4547A),
      chartGrid: Color(0xFFE8C4CF),
      chartPrimary: Color(0xFFD4547A),
      chartSecondary: Color(0xFF6B4558),
      chartWarning: Color(0xFFC08030),
      glassFill: Color(0xCCFFFBFC),
    ),
  );

  static final macaron = ThemeTokens(
    preset: ThemePreset.macaron,
    brightness: Brightness.light,
    glowIntensity: 0.07,
    blur: AppBlur.low,
    radius: AppRadius.r16,
    chart: chart,
    colors: const AppColors(
      background: Color(0xFFF5F8FF),
      surface: Color(0xFFFCFEFF),
      surfaceHigh: Color(0xFFE8F0FA),
      border: Color(0xFFC8D8EC),
      accent: Color(0xFF6BA3E8),
      onAccent: Color(0xFF0A2848),
      textPrimary: Color(0xFF1A2840),
      textSecondary: Color(0xFF4A5870),
      textMuted: Color(0xFF7888A0),
      warning: Color(0xFFE8A848),
      danger: Color(0xFFE07088),
      success: Color(0xFF58B888),
      glow: Color(0x226BA3E8),
      chartGrid: Color(0xFFC8D8EC),
      chartPrimary: Color(0xFF6BA3E8),
      chartSecondary: Color(0xFF4A5870),
      chartWarning: Color(0xFFE8A848),
      glassFill: Color(0xCCFCFEFF),
    ),
  );

  static ThemeTokens byPreset(ThemePreset preset) => switch (preset) {
        ThemePreset.voidTheme => voidTheme,
        ThemePreset.terminal => terminal,
        ThemePreset.akira => akira,
        ThemePreset.ice => ice,
        ThemePreset.light => light,
        ThemePreset.noir => noir,
        ThemePreset.sakura => sakura,
        ThemePreset.macaron => macaron,
        ThemePreset.custom => voidTheme.copyWith(preset: ThemePreset.custom),
      };
}
