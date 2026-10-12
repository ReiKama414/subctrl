import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openConnection(String name) => driftDatabase(name: name);

QueryExecutor openMemoryExecutor() => NativeDatabase.memory();
