import 'package:bp_records/models/bp_record.dart';
import 'package:flutter/foundation.dart';

class AppDataProvider with ChangeNotifier {
  List<BpRecord> records = [
    BpRecord(
        id: 1,
        dateTaken: DateTime.now(),
        systolic: 120,
        diastolic: 93,
        pulse: 97),
    BpRecord(
        id: 2,
        dateTaken: DateTime.now(),
        systolic: 120,
        diastolic: 93,
        pulse: 97),
    BpRecord(
        id: 3,
        dateTaken: DateTime.now(),
        systolic: 120,
        diastolic: 93,
        pulse: 97),
    BpRecord(
        id: 4,
        dateTaken: DateTime.now(),
        systolic: 120,
        diastolic: 93,
        pulse: 97),
  ];

  String? validateSystolic(String? reading) {
    int? val = int.tryParse(reading ?? "");
    if (val == null || val <= 0 || val >= 200) {
      return "Invalid value entered. Must be a +ive integer value";
    } else {
      return null;
    }
  }

  String? validateDiastolic(String? reading) {
    int? val = int.tryParse(reading ?? "");
    if (val == null || val <= 0 || val >= 200) {
      return "Invalid value entered. Must be a +ive integer value";
    } else {
      return null;
    }
  }

  String? validatePulse(String? reading) {
    int? val = int.tryParse(reading ?? "");
    if (val == null || val <= 0 || val >= 200) {
      return "Invalid value entered. Must be a +ive integer value";
    } else {
      return null;
    }
  }
}
