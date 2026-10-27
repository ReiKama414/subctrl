import 'package:subctrl/core/constants/enums.dart';

/// Progress order for timeline UI (excludes cancelled).
const purchaseStatusPipeline = [
  PurchaseStatus.preorder,
  PurchaseStatus.ordered,
  PurchaseStatus.awaitingShipment,
  PurchaseStatus.shipped,
  PurchaseStatus.delivered,
];

PurchaseStatus? purchaseNextStatus(PurchaseStatus current) {
  if (current == PurchaseStatus.cancelled || current == PurchaseStatus.delivered) return null;
  final i = purchaseStatusPipeline.indexOf(current);
  if (i < 0) return PurchaseStatus.awaitingShipment;
  if (i >= purchaseStatusPipeline.length - 1) return null;
  return purchaseStatusPipeline[i + 1];
}

int purchaseStatusIndex(PurchaseStatus s) {
  final i = purchaseStatusPipeline.indexOf(s);
  return i < 0 ? 0 : i;
}

bool purchaseIsOverdue(DateTime? expectedAt, PurchaseStatus status) {
  if (expectedAt == null || !status.isPending) return false;
  final today = DateTime.now();
  final e = DateTime(expectedAt.year, expectedAt.month, expectedAt.day);
  final t = DateTime(today.year, today.month, today.day);
  return e.isBefore(t);
}

int? purchaseDaysUntil(DateTime? expectedAt) {
  if (expectedAt == null) return null;
  final today = DateTime.now();
  final e = DateTime(expectedAt.year, expectedAt.month, expectedAt.day);
  final t = DateTime(today.year, today.month, today.day);
  return e.difference(t).inDays;
}
