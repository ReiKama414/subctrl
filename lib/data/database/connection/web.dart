import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openConnection(String name) {
  return driftDatabase(
    name: name,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

QueryExecutor openMemoryExecutor() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'subctrl_mem',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return result.resolvedExecutor;
  }));
}
