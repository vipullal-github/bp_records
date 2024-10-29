import 'package:bp_records/models/bp_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:bp_records/domain/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    return Future(() async {
      print("setup caled");
      databaseFactory = databaseFactoryFfi;
      sqfliteFfiInit();
      await Repository().initInstance(inMemoryDatabasePath); // :memory:
      print("setup finished");
    });
  });

  test("Test insertion", () async {
    BpRecord rec = BpRecord(
        id: -1,
        dateTaken: DateTime.now(),
        systolic: 100,
        diastolic: 80,
        pulse: 60);
    rec = await Repository().insertRecord(rec);
    expect(1, rec.id);
  });
}
