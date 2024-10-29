import 'package:flutter_test/flutter_test.dart';
import 'package:bp_records/models/bp_record.dart';

void main() {
  test("Parsing of BP Record", () {
    Map<String, dynamic> testDats = {
      'id': 1,
      'dateTaken': DateTime.now(),
      'systolic': 100,
      'diastolic': 80,
      'pulse': 80,
      'temperature': 39.1,
      'notes': 'important'
    };

    BpRecord record = BpRecord.fromJson(testDats);
    expect(100, record.systolic);
    expect(39.1, record.temperature);
  });
}
