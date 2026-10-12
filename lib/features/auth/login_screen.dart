import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/app_info.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/auth_service.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? _error;
  bool _busy = false;

  Future<void> _go(String providerId) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final identity = await ref.read(authServiceProvider).byId(providerId).signIn();
      await ref.read(settingsRepoProvider).linkIdentity(
            provider: identity.provider,
            providerUserId: identity.providerUserId,
            email: identity.email,
            displayName: identity.displayName,
          );
      final ids = await ref.read(settingsRepoProvider).identities();
      ref.read(sessionProvider.notifier).setProviders(
            ids.map((e) => e.provider).toSet(),
            name: identity.displayName,
            email: identity.email,
          );
      if (!mounted) return;
      final prefs = await ref.read(settingsRepoProvider).get();
      if (!mounted) return;
      context.go(prefs.onboardingComplete ? '/home' : '/onboarding');
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _AuthBgPainter(c.accent, c.border)),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GlassPanel(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppInfo.mark, style: AppTypography.display(c.accent, size: 28)),
                        const SizedBox(height: 12),
                        Text(AppInfo.name, style: AppTypography.label(c.textPrimary).copyWith(fontSize: 16)),
                        const SizedBox(height: 6),
                        Text(l10n.appTagline, style: AppTypography.body(c.textSecondary)),
                        const SizedBox(height: 8),
                        Text(
                          l10n.loginLead,
                          textAlign: TextAlign.center,
                          style: AppTypography.body(c.textMuted),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _busy ? null : () => _go(AuthProviderId.guest.name),
                            child: Text(l10n.continueLocally),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.loginOptionalHint,
                          textAlign: TextAlign.center,
                          style: AppTypography.body(c.textMuted).copyWith(fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _busy ? null : () => _go(AuthProviderId.google.name),
                            child: Text(l10n.continueGoogle),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _busy ? null : () => _go(AuthProviderId.line.name),
                            child: Text(l10n.continueLine),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(_error!, style: AppTypography.body(c.danger), textAlign: TextAlign.center),
                        ],
                        const SizedBox(height: 16),
                        Text(l10n.loginFooter, textAlign: TextAlign.center, style: AppTypography.body(c.textMuted)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthBgPainter extends CustomPainter {
  _AuthBgPainter(this.accent, this.line);
  final Color accent;
  final Color line;
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = line
      ..strokeWidth = 1;
    for (var i = 0; i < 8; i++) {
      canvas.drawLine(Offset(0, size.height * i / 8), Offset(size.width, size.height * (i / 8 + 0.08)), p);
    }
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 80, Paint()..color = accent.withValues(alpha: 0.04));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
