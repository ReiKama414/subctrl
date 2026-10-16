import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/presets.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';

class AppTheme {
  static ThemeData fromTokens(ThemeTokens tokens, {bool reduceMotion = false}) {
    final c = tokens.colors;
    final radius = BorderRadius.circular(tokens.radius);
    final fieldRadius = BorderRadius.circular(AppRadius.r12);
    const buttonShape = StadiumBorder();
    const buttonSize = Size(64, 48);
    final buttonText = AppTypography.label().copyWith(fontSize: 14, letterSpacing: 0.3);
    return ThemeData(
      useMaterial3: true,
      brightness: tokens.brightness,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      splashFactory: InkSparkle.splashFactory,
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
        surfaceContainerLowest: c.background,
        surfaceContainerLow: c.surface,
        surfaceContainer: c.surface,
        surfaceContainerHigh: c.surfaceHigh,
        surfaceContainerHighest: c.surfaceHigh,
        onSurfaceVariant: c.textSecondary,
        outline: c.border,
        outlineVariant: c.border,
      ),
      textTheme: TextTheme(
        headlineSmall: AppTypography.headline(c.textPrimary),
        titleLarge: AppTypography.title(c.textPrimary).copyWith(fontSize: 20),
        titleMedium: AppTypography.title(c.textPrimary).copyWith(fontSize: 16),
        titleSmall: AppTypography.label(c.textPrimary).copyWith(fontSize: 14),
        bodyLarge: AppTypography.body(c.textPrimary).copyWith(fontSize: 15),
        bodyMedium: AppTypography.body(c.textPrimary),
        bodySmall: AppTypography.caption(c.textSecondary),
        labelLarge: buttonText,
        labelMedium: AppTypography.label(c.textSecondary),
        labelSmall: AppTypography.label(c.textMuted).copyWith(fontSize: 11),
      ),
      iconTheme: IconThemeData(color: c.textSecondary, size: 22),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.title(c.textPrimary),
      ),
      dividerColor: c.border,
      dividerTheme: DividerThemeData(color: c.border, thickness: 1, space: 1),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.textSecondary,
        textColor: c.textPrimary,
        titleTextStyle: AppTypography.body(c.textPrimary).copyWith(fontSize: 15, fontWeight: FontWeight.w500),
        subtitleTextStyle: AppTypography.caption(c.textMuted),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r12)),
        minVerticalPadding: 10,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceHigh,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: fieldRadius, borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: fieldRadius, borderSide: BorderSide(color: c.border.withValues(alpha: 0.6))),
        focusedBorder: OutlineInputBorder(borderRadius: fieldRadius, borderSide: BorderSide(color: c.accent, width: 1.5)),
        labelStyle: AppTypography.body(c.textMuted),
        floatingLabelStyle: AppTypography.label(c.accent),
        hintStyle: AppTypography.body(c.textMuted),
        prefixIconColor: c.textMuted,
        suffixIconColor: c.textMuted,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: c.onAccent,
          minimumSize: buttonSize,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.textPrimary,
          minimumSize: buttonSize,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          side: BorderSide(color: c.border),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.accent,
          shape: buttonShape,
          textStyle: buttonText.copyWith(fontSize: 13),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: c.textSecondary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
        foregroundColor: c.onAccent,
        elevation: 0,
        shape: const CircleBorder(),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surfaceHigh,
        selectedColor: c.accent,
        secondarySelectedColor: c.accent,
        disabledColor: c.surfaceHigh,
        // Unselected chips sit on surface cards — lift them with a brighter fill + border.
        color: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return c.accent;
          if (s.contains(WidgetState.disabled)) return c.surfaceHigh.withValues(alpha: 0.5);
          return Color.lerp(c.surfaceHigh, c.textPrimary, 0.08)!;
        }),
        labelStyle: WidgetStateTextStyle.resolveWith(
          (s) => AppTypography.label(
            s.contains(WidgetState.selected) ? c.onAccent : c.textPrimary,
          ).copyWith(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        secondaryLabelStyle: AppTypography.label(c.onAccent).copyWith(fontSize: 13),
        side: WidgetStateBorderSide.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return BorderSide.none;
          return BorderSide(color: c.border);
        }),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: const StadiumBorder(),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.onAccent : c.textMuted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accent : c.surfaceHigh,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Colors.transparent : c.border,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r6)),
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accent : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(c.onAccent),
        side: BorderSide(color: c.textMuted, width: 1.5),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.accent, linearTrackColor: c.surfaceHigh),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r24)),
        titleTextStyle: AppTypography.title(c.textPrimary).copyWith(fontSize: 18),
        contentTextStyle: AppTypography.body(c.textSecondary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: c.surface,
        showDragHandle: true,
        dragHandleColor: c.border,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r24)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.surfaceHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r16)),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(c.surfaceHigh),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          backgroundColor: c.surfaceHigh,
          foregroundColor: c.textSecondary,
          selectedBackgroundColor: c.accent,
          selectedForegroundColor: c.onAccent,
          side: BorderSide.none,
          shape: buttonShape,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: c.surfaceHigh,
        contentTextStyle: AppTypography.body(c.textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r16)),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: c.surfaceHigh, borderRadius: BorderRadius.circular(AppRadius.r8)),
        textStyle: AppTypography.caption(c.textPrimary),
      ),
      pageTransitionsTheme: reduceMotion
          ? const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              },
            )
          : const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
      extensions: [c, tokens.chart],
    );
  }

  static BoxConstraints get pageConstraints =>
      const BoxConstraints(maxWidth: AppInfo.maxContentWidth);
}
