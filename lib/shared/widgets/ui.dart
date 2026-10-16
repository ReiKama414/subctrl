import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';
import 'package:subctrl/core/services/security_service.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppInfo.maxContentWidth),
        // Force full width up to the cap so pages don't shrink on wide web.
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Large title row used at the top of each bottom-nav tab.
class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, this.subtitle, this.actions = const []});
  final String title;
  final String? subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null) ...[
                  Text(subtitle!, style: AppTypography.caption(c.textMuted)),
                  const SizedBox(height: 2),
                ],
                Text(title, style: AppTypography.headline(c.textPrimary)),
              ],
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}

/// Round tonal icon button used in headers.
class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({super.key, required this.icon, required this.onPressed, this.tooltip});
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: IconButton.filledTonal(
        tooltip: tooltip,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: c.surfaceHigh,
          foregroundColor: c.textPrimary,
          fixedSize: const Size(42, 42),
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.label(context.colors.textMuted));
  }
}

/// Section title with an optional trailing action ("See all").
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.actionLabel, this.onAction, this.trailing});
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            Expanded(child: Text(title, style: AppTypography.title(c.textPrimary))),
            ?trailing,
            if (actionLabel != null && onAction != null)
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(actionLabel!),
                    const SizedBox(width: 2),
                    const Icon(Icons.chevron_right_rounded, size: 18),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Settings / form block: small label above a grouped card.
class SettingsBlock extends StatelessWidget {
  const SettingsBlock({super.key, required this.label, required this.children, this.top = 24});
  final String label;
  final List<Widget> children;
  final double top;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: SectionLabel(label),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(AppRadius.r20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class TerminalAmount extends StatelessWidget {
  const TerminalAmount(this.text, {super.key, this.size = 32, this.color});
  final String text;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.display(color ?? context.colors.textPrimary, size: size),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class GlassBar extends StatelessWidget {
  const GlassBar({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppBlur.medium, sigmaY: AppBlur.medium),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: c.glassFill,
            border: Border(top: BorderSide(color: c.border.withValues(alpha: 0.6))),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassPanel extends StatelessWidget {
  const GlassPanel({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.r20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppBlur.low, sigmaY: AppBlur.low),
        child: Container(
          decoration: BoxDecoration(
            color: c.glassFill,
            borderRadius: BorderRadius.circular(AppRadius.r20),
            border: Border.all(color: c.border),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({super.key, required this.child, this.onTap, this.padding, this.color, this.radius});
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = BorderRadius.circular(radius ?? AppRadius.r20);
    return Material(
      color: color ?? c.surface,
      borderRadius: r,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

class EmptyNote extends StatelessWidget {
  const EmptyNote({
    super.key,
    required this.title,
    required this.body,
    this.action,
    this.actionLabel,
    this.icon = Icons.inbox_rounded,
  });
  final String title;
  final String body;
  final VoidCallback? action;
  final String? actionLabel;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
      child: Column(
        children: [
          IconBadge(icon: icon, color: c.accent, size: 64, iconSize: 30),
          const SizedBox(height: 16),
          Text(title, textAlign: TextAlign.center, style: AppTypography.title(c.textPrimary)),
          const SizedBox(height: 6),
          Text(body, textAlign: TextAlign.center, style: AppTypography.body(c.textSecondary)),
          if (action != null) ...[
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: action,
              icon: const Icon(Icons.add_rounded, size: 20),
              label: Text(actionLabel ?? 'ADD SUBSCRIPTION'),
            ),
          ],
        ],
      ),
    );
  }
}

class SkeletonBlock extends StatelessWidget {
  const SkeletonBlock({super.key, this.height = 16, this.width});
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.colors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
    );
  }
}

/// Tinted pill badge for status / phase labels.
class StatusMark extends StatelessWidget {
  const StatusMark(this.label, {super.key, this.tone, this.icon});
  final String label;
  final Color? tone;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = tone ?? c.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppTypography.label(color).copyWith(fontSize: 11, height: 1.1)),
        ],
      ),
    );
  }
}

/// Circle with a tinted background and an icon.
class IconBadge extends StatelessWidget {
  const IconBadge({super.key, required this.icon, required this.color, this.size = 40, this.iconSize = 20});
  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: iconSize, color: color),
    );
  }
}

/// Colored rounded tile with service initials, stable color per name.
class ServiceAvatar extends StatelessWidget {
  const ServiceAvatar(this.name, {super.key, this.size = 44, this.dimmed = false});
  final String name;
  final double size;
  final bool dimmed;

  static String initialsOf(String name) {
    final latin = const ServiceLogoResolver().initials(name).trim();
    if (latin.isNotEmpty) return latin.toUpperCase();
    final trimmed = name.trim();
    return trimmed.isEmpty ? '?' : trimmed.characters.first;
  }

  @override
  Widget build(BuildContext context) {
    final color = AppPalette.forKey(name);
    return Opacity(
      opacity: dimmed ? 0.45 : 1,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, Color.lerp(color, Colors.black, 0.18)!],
          ),
          borderRadius: BorderRadius.circular(size * 0.3),
        ),
        child: Text(
          initialsOf(name),
          style: AppTypography.sans.copyWith(
            fontSize: size * 0.36,
            fontWeight: FontWeight.w800,
            color: AppPalette.onSwatch,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class InitialsMark extends StatelessWidget {
  const InitialsMark(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => ServiceAvatar(text, size: 40);
}

/// Thin rounded progress bar.
class ProgressPill extends StatelessWidget {
  const ProgressPill({super.key, required this.value, required this.color, this.track, this.height = 8});
  final double value;
  final Color color;
  final Color? track;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: track ?? context.colors.surfaceHigh)),
            FractionallySizedBox(
              widthFactor: value.clamp(0, 1).toDouble(),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
