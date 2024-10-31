import 'package:bp_records/models/bp_record.dart';
import 'package:flutter/foundation.dart';
import 'package:bp_records/domain/repository.dart';

enum ProviderState {
  stateInitial,
  stateInitialDataLoaded,
  stateBeginEdit,
  stateEditSaved
}

//------------------------------------
class AppDataProvider with ChangeNotifier {
  ProviderState _currentState = ProviderState.stateInitial;
  ProviderState get state => _currentState;

  // ------------
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

  BpRecord currentRecord = BpRecord(
      id: -1,
      dateTaken: DateTime.now(),
      systolic: 100,
      diastolic: 60,
      pulse: 70);

  // ------------------------------
  Future<void> initSelf() async {
    await Repository().initInstance("bp_records.db");
    records = await Repository().getAllRecords();
    _currentState = ProviderState.stateInitialDataLoaded;
    notifyListeners();
  }

  // ------------------------------
  void addRecord() {
    currentRecord = BpRecord(
        id: -1,
        dateTaken: DateTime.now(),
        systolic: 100,
        diastolic: 60,
        pulse: 70);
    _currentState = ProviderState.stateBeginEdit;
    notifyListeners();
  }

  // ------------------------------
  String? validateSystolic(String? reading) {
    int? val = int.tryParse(reading ?? "");
    if (val == null || val <= 0 || val >= 200) {
      return "Invalid value entered. Must be a +ive integer value";
    } else {
      return null;
    }
  }

  // ------------------------------
  String? validateDiastolic(String? reading) {
    int? val = int.tryParse(reading ?? "");
    if (val == null || val <= 0 || val >= 200) {
      return "Invalid value entered. Must be a +ive integer value";
    } else {
      return null;
    }
  }

  // ------------------------------
  String? validatePulse(String? reading) {
    int? val = int.tryParse(reading ?? "");
    if (val == null || val <= 0 || val >= 200) {
      return "Invalid value entered. Must be a +ive integer value";
    } else {
      return null;
    }
  }

  // --------------------------------------
  Future<void> saveCurrentRecord(
      String sys, String dia, String pulse, String temp) async {
    currentRecord.systolic = int.parse(sys);
    currentRecord.diastolic = int.parse(dia);
    currentRecord.pulse = int.parse(pulse);
    currentRecord.temperature = double.tryParse(temp);
    if (currentRecord.id >= 1) {
      await Repository().saveRecord(currentRecord);
    } else {
      await Repository().insertRecord(currentRecord);
      records.add(currentRecord);
    }
    _currentState = ProviderState.stateEditSaved;
    notifyListeners();
  }
}
