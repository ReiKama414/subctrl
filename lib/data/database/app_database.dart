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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? connection.openConnection('subctrl'));

  factory AppDatabase.memory() => AppDatabase(connection.openMemoryExecutor());

  @override
  int get schemaVersion => 3;

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
        },
      );
}
