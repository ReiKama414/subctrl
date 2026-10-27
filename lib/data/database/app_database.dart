import 'package:drift/drift.dart';
import 'package:subctrl/data/database/tables.dart';

import 'connection/native.dart' if (dart.library.html) 'connection/web.dart' as connection;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserAccounts,
    LinkedIdentities,
    UserProfiles,
    Categories,
    Services,
    Plans,
    PaymentMethods,
    Subscriptions,
    PricePhases,
    PaymentRecords,
    PriceHistory,
    SubscriptionEvents,
    Reminders,
    CurrencyRates,
    Budgets,
    UserPreferences,
    AppThemeRows,
    PurchaseOrders,
    PurchaseOrderEvents,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? connection.openConnection('subctrl'));

  factory AppDatabase.memory() => AppDatabase(connection.openMemoryExecutor());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(userPreferences, userPreferences.localeCode);
          }
          if (from < 3) {
            await m.createTable(purchaseOrders);
          }
          if (from < 4) {
            await m.addColumn(userPreferences, userPreferences.notificationsEnabled);
            await m.addColumn(userPreferences, userPreferences.cloudAutoDownload);
            await m.addColumn(userPreferences, userPreferences.cloudAutoUpload);
          }
          if (from < 5) {
            await m.addColumn(purchaseOrders, purchaseOrders.orderKind);
            await m.addColumn(purchaseOrders, purchaseOrders.depositPaid);
            await m.addColumn(purchaseOrders, purchaseOrders.balanceDue);
            await m.addColumn(purchaseOrders, purchaseOrders.shippingFee);
            await m.addColumn(purchaseOrders, purchaseOrders.serviceFee);
            await m.addColumn(purchaseOrders, purchaseOrders.sellerName);
            await m.addColumn(purchaseOrders, purchaseOrders.orderNumber);
            await m.addColumn(purchaseOrders, purchaseOrders.trackingNumber);
            await m.addColumn(purchaseOrders, purchaseOrders.forwarder);
            await m.addColumn(purchaseOrders, purchaseOrders.paymentNote);
            await m.createTable(purchaseOrderEvents);
          }
        },
      );
}
