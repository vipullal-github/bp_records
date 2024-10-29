class BpRecord {
  int id;
  DateTime dateTaken;
  int systolic;
  int diastolic;
  int pulse;
  double? temperature;
  String? notes;

  BpRecord(
      {required this.id,
      required this.dateTaken,
      required this.systolic,
      required this.diastolic,
      required this.pulse,
      this.temperature,
      this.notes});

  // Factory constructor to create a BpRecord instance from a JSON map
  factory BpRecord.fromJson(Map<String, dynamic> json) {
    return BpRecord(
      id: json['id'],
      dateTaken: json['dateTaken'],
      systolic: json['systolic'],
      diastolic: json['diastolic'],
      pulse: json['pulse'],
      temperature: json['temperature']?.toDouble(),
      notes: json['notes'],
    );
  }

  // -----------------------------------
  Map<String, dynamic> toDatabase() {
    Map<String, dynamic> toRet = {};
    if (temperature != null) {
      toRet['temperature'] = temperature;
    }
    if (notes != null) {
      toRet['notes'] = notes;
    }
    toRet.addAll({
      'id': id,
      "dateTaken": dateTaken.millisecondsSinceEpoch,
      "systolic": systolic,
      "diastolic": diastolic,
      "pulse": pulse,
    });
    return toRet;
  }
}
