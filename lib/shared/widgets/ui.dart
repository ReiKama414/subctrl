import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';

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
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
            child: child,
          ),
        ),
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

/// Settings / form block with consistent vertical rhythm.
class SettingsBlock extends StatelessWidget {
  const SettingsBlock({super.key, required this.label, required this.children, this.top = 28});
  final String label;
  final List<Widget> children;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionLabel(label),
          const SizedBox(height: 12),
          ...children,
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
        filter: ImageFilter.blur(sigmaX: AppBlur.low, sigmaY: AppBlur.low),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: c.glassFill,
            border: Border(top: BorderSide(color: c.border)),
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
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppBlur.low, sigmaY: AppBlur.low),
        child: Container(
          decoration: BoxDecoration(
            color: c.glassFill,
            borderRadius: BorderRadius.circular(AppRadius.r12),
            border: Border.all(color: c.border),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({super.key, required this.child, this.onTap, this.padding});
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final body = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.r6),
        border: Border.all(color: c.border),
      ),
      child: child,
    );
    if (onTap == null) return body;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.r6),
        child: body,
      ),
    );
  }
}

class EmptyNote extends StatelessWidget {
  const EmptyNote({super.key, required this.title, required this.body, this.action, this.actionLabel});
  final String title;
  final String body;
  final VoidCallback? action;
  final String? actionLabel;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(title, style: AppTypography.label(c.textPrimary)),
          const SizedBox(height: 12),
          Text(body, textAlign: TextAlign.center, style: AppTypography.body(c.textSecondary)),
          if (action != null) ...[
            const SizedBox(height: 20),
            FilledButton(onPressed: action, child: Text(actionLabel ?? '+ ADD SUBSCRIPTION')),
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
        borderRadius: BorderRadius.circular(AppRadius.r4),
      ),
    );
  }
}

class StatusMark extends StatelessWidget {
  const StatusMark(this.label, {super.key, this.tone});
  final String label;
  final Color? tone;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = tone ?? c.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(AppRadius.r2),
      ),
      child: Text(label, style: AppTypography.label(color).copyWith(fontSize: 10)),
    );
  }
}

class InitialsMark extends StatelessWidget {
  const InitialsMark(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.r4),
        border: Border.all(color: c.border),
      ),
      child: Text(text.toUpperCase(), style: AppTypography.label(c.textPrimary).copyWith(fontSize: 11)),
    );
  }
}
