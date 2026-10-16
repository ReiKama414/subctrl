import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class ProfileSwitcher extends ConsumerWidget {
  const ProfileSwitcher({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(profilesProvider);
    final profiles = async.valueOrNull ?? [];
    final activeId = ref.watch(activeProfileIdProvider);
    final l10n = context.l10n;

    // Reserve chip-row height while profiles load so the page doesn't jump.
    if (async.isLoading && profiles.isEmpty) {
      return const SizedBox(
        height: 36,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SkeletonBlock(height: 32, width: 220),
        ),
      );
    }
    if (profiles.isEmpty) return const SizedBox.shrink();

    final chips = <Widget>[
      _ProfilePill(
        label: compact ? l10n.allProfilesShort : l10n.allProfiles,
        selected: activeId == null,
        onTap: () => ref.read(settingsRepoProvider).patch(
              const UserPreferencesCompanion(activeProfileId: Value(null)),
            ),
      ),
      for (final p in profiles)
        _ProfilePill(
          label: l10n.profileDisplayName(p.type, p.name),
          selected: activeId == p.id,
          onTap: () => ref.read(settingsRepoProvider).patch(
                UserPreferencesCompanion(activeProfileId: Value(p.id)),
              ),
        ),
    ];

    if (compact) {
      return SizedBox(
        height: 36,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // Avoid clipping glyph ink while fonts settle on first paint.
          clipBehavior: Clip.none,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < chips.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                chips[i],
              ],
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips,
    );
  }
}

/// Custom pill — Material [ChoiceChip] was squashing CJK labels on first layout.
class _ProfilePill extends StatelessWidget {
  const _ProfilePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bg = selected ? c.accent : Color.lerp(c.surfaceHigh, c.textPrimary, 0.08)!;
    final fg = selected ? c.onAccent : c.textPrimary;
    final border = selected ? c.accent : c.border;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: border, width: 1),
          ),
          child: Text(
            label,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: AppTypography.sans.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              // letterSpacing stretches/squishes CJK on web first paint — keep 0.
              letterSpacing: 0,
              height: 1.1,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSectionLabel extends ConsumerWidget {
  const ProfileSectionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(activeProfileIdProvider);
    final profiles = ref.watch(profilesProvider).valueOrNull ?? [];
    final l10n = context.l10n;
    final name = id == null
        ? l10n.allProfiles
        : profiles
                .where((p) => p.id == id)
                .map((p) => l10n.profileDisplayName(p.type, p.name))
                .firstOrNull ??
            l10n.profile;
    return Text(name, style: AppTypography.label(context.colors.textMuted));
  }
}
