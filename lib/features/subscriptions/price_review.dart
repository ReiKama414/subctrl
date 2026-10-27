import 'package:flutter/material.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/l10n/app_localizations.dart';

Future<bool> showPriceReviewDialog({
  required BuildContext context,
  required SubscriptionRepository repo,
  required SubscriptionView sub,
}) async {
  final l10n = context.l10n;
  final proposed = sub.proposedResumePrice();
  final priceCtrl = TextEditingController(
    text: proposed == proposed.roundToDouble() ? '${proposed.round()}' : '$proposed',
  );
  final cycle = BillingCycle.values.where((e) => e.name == sub.billingCycle).firstOrNull ?? BillingCycle.monthly;
  final formatted = MoneyMath.format(proposed, sub.endedOfferPhase()?.regularCurrency ?? sub.currency);
  final body = sub.status == SubscriptionStatus.promo
      ? l10n.priceReviewPromoBody(formatted, l10n.billingCycleLabel(cycle))
      : l10n.priceReviewFreeBody(formatted, l10n.billingCycleLabel(cycle));

  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.actionPriceReview),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(body, style: AppTypography.body(ctx.colors.textSecondary)),
            const SizedBox(height: 16),
            TextField(
              controller: priceCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.currentPrice),
              autofocus: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.priceReviewLater)),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.priceReviewConfirm)),
      ],
    ),
  );
  final raw = priceCtrl.text;
  priceCtrl.dispose();
  if (ok != true) return false;
  final parsed = double.tryParse(raw.trim());
  if (parsed == null || parsed < 0) return false;
  await repo.confirmPostOfferPrice(
    id: sub.id,
    price: parsed,
    currency: sub.currency,
    billingCycle: sub.billingCycle,
  );
  return true;
}
