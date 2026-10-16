import 'package:drift/drift.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:uuid/uuid.dart';

class PurchaseOrderView {
  const PurchaseOrderView({
    required this.id,
    required this.profileId,
    required this.platform,
    required this.title,
    required this.quantity,
    required this.status,
    required this.orderedAt,
    this.expectedAt,
    this.deliveredAt,
    this.reminderAt,
    this.price,
    this.currency,
    this.trackingUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String profileId;
  final String platform;
  final String title;
  final int quantity;
  final PurchaseStatus status;
  final DateTime orderedAt;
  final DateTime? expectedAt;
  final DateTime? deliveredAt;
  final DateTime? reminderAt;
  final double? price;
  final String? currency;
  final String? trackingUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isPending => status.isPending;
}

class PurchaseRepository {
  PurchaseRepository(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Stream<List<PurchaseOrderView>> watchAll() {
    return db.select(db.purchaseOrders).watch().map(
          (rows) => rows.map(_map).toList()
            ..sort((a, b) {
              final ae = a.expectedAt ?? a.orderedAt;
              final be = b.expectedAt ?? b.orderedAt;
              return ae.compareTo(be);
            }),
        );
  }

  Future<List<PurchaseOrderView>> listAll() async {
    final rows = await db.select(db.purchaseOrders).get();
    return rows.map(_map).toList();
  }

  Future<PurchaseOrderView?> getById(String id) async {
    final row = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _map(row);
  }

  Future<String> create({
    required String profileId,
    required String platform,
    required String title,
    required PurchaseStatus status,
    required DateTime orderedAt,
    int quantity = 1,
    DateTime? expectedAt,
    DateTime? reminderAt,
    double? price,
    String? currency,
    String? trackingUrl,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await db.into(db.purchaseOrders).insert(
          PurchaseOrdersCompanion.insert(
            id: id,
            profileId: profileId,
            platform: platform.trim(),
            title: title.trim(),
            quantity: Value(quantity),
            status: status.name,
            orderedAt: orderedAt,
            expectedAt: Value(expectedAt),
            reminderAt: Value(reminderAt),
            price: Value(price),
            currency: Value(currency),
            trackingUrl: Value(trackingUrl),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> updateStatus(String id, PurchaseStatus status) async {
    final now = DateTime.now();
    await (db.update(db.purchaseOrders)..where((t) => t.id.equals(id))).write(
      PurchaseOrdersCompanion(
        status: Value(status.name),
        deliveredAt: status == PurchaseStatus.delivered ? Value(now) : const Value.absent(),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> update(PurchaseOrdersCompanion companion) {
    return (db.update(db.purchaseOrders)..where((t) => t.id.equals(companion.id.value))).write(
      companion.copyWith(updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> delete(String id) {
    return (db.delete(db.purchaseOrders)..where((t) => t.id.equals(id))).go();
  }

  PurchaseOrderView _map(PurchaseOrder row) {
    return PurchaseOrderView(
      id: row.id,
      profileId: row.profileId,
      platform: row.platform,
      title: row.title,
      quantity: row.quantity,
      status: PurchaseStatus.values.byName(row.status),
      orderedAt: row.orderedAt,
      expectedAt: row.expectedAt,
      deliveredAt: row.deliveredAt,
      reminderAt: row.reminderAt,
      price: row.price,
      currency: row.currency,
      trackingUrl: row.trackingUrl,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
