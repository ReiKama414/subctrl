import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class PaymentMethodsScreen extends ConsumerStatefulWidget {
  const PaymentMethodsScreen({super.key});
  @override
  ConsumerState<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends ConsumerState<PaymentMethodsScreen> {
  final last4 = TextEditingController();
  PaymentMethodType type = PaymentMethodType.visa;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final methods = ref.watch(paymentMethodsProvider).valueOrNull ?? [];
    final subs = ref.watch(subscriptionsProvider).valueOrNull ?? [];
    final fx = ref.watch(currencyEngineProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.paymentMethods)),
      body: AppPage(
        child: ListView(
          children: [
            for (final m in methods)
              SurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.display),
                    Text('${l10n.expiry} ${m.expiry?.toIso8601String().substring(0, 7) ?? '—'}'),
                    Text(
                      '${l10n.monthlyCost} ${MoneyMath.format(subs.where((s) => s.paymentMethodId == m.id).fold<double>(0, (p, s) => p + fx.monthlyBase(s)), fx.baseCurrency)}',
                    ),
                    Text('${subs.where((s) => s.paymentMethodId == m.id).length} ${l10n.subscriptions}'),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            DropdownButton<PaymentMethodType>(
              value: type,
              items: [for (final t in PaymentMethodType.values) DropdownMenuItem(value: t, child: Text(t.label))],
              onChanged: (v) => setState(() => type = v ?? type),
            ),
            TextField(controller: last4, maxLength: 4, decoration: const InputDecoration(labelText: 'Last 4')),
            FilledButton(
              onPressed: () async {
                await ref.read(financeRepoProvider).addMethod(
                      PaymentMethodView(
                        id: '',
                        label: type.label,
                        type: type,
                        brand: type.label,
                        last4: last4.text.isEmpty ? null : last4.text,
                      ),
                    );
                ref.invalidate(paymentMethodsProvider);
              },
              child: Text(l10n.addMethod),
            ),
          ],
        ),
      ),
    );
  }
}
