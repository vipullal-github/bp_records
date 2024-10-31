import 'package:bp_records/models/bp_record.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  static final Repository _instance = Repository._();
  factory Repository() => _instance;

  Repository._();

  Future<void> initInstance(String fileName) async {
    mDB = await openDatabase(fileName,
        version: 1, onCreate: (db, version) => _createTables(db));
  }

  static const String _bpRecTbl = "bp_records";

  final String _createTableSql = """
  CREATE TABLE $_bpRecTbl(

    id INTEGER PRIMARY KEY AUTOINCREMENT,
    dateTaken INTEGER NOT NULL,
    systolic INTEGER,
    diastolic INTEGER,
    pulse INTEGER,
    temperature REAL,
    notes TEXT
  );
""";

  void _createTables(Database db) {
    db.execute(_createTableSql);
  }

  // --------------
  late Database mDB;

  Map<String, dynamic> _record2Row(BpRecord rec) {
    return {
      'dateTaken': rec.dateTaken.millisecondsSinceEpoch,
      'systolic': rec.systolic,
      'diastolic': rec.diastolic,
      'pulse': rec.pulse,
      'temperature': rec.temperature,
      'notes': rec.notes
    };
  }

  BpRecord _recordFromDb(Map<String, dynamic> rowData) {
    return BpRecord(
      id: rowData['id'],
      dateTaken: DateTime.fromMillisecondsSinceEpoch(rowData['dateTaken']),
      systolic: rowData['systoloc'],
      diastolic: rowData['diastolic'],
      pulse: rowData['pulse'],
    );
  }

  // ------------------------------
  Future<List<BpRecord>> getAllRecords() async {
    List<BpRecord> records = [];
    var dataRows = await mDB.query(_bpRecTbl, orderBy: "dateTaken");
    for (Map<String, dynamic> r in dataRows) {
      BpRecord rec = BpRecord.fromJson(r);
      records.add(rec);
    }
    return records;
  }

  // -------------------------------
  Future<BpRecord> insertRecord(BpRecord record) async {
    Map<String, dynamic> rowData = _record2Row(record);
    int newId = await mDB.insert(_bpRecTbl, rowData);
    record.id = newId;
    return record;
  }

  // -------------------------------
  Future<BpRecord?> getRecordById(int id) async {
    List<Map<String, dynamic>> rowData =
        await mDB.query(_bpRecTbl, where: 'id=?', whereArgs: [id]);
    if (rowData.isNotEmpty) {
      return _recordFromDb(rowData.first);
    }
    return null;
  }

  // -------------------------------
  Future<int> saveRecord(BpRecord currentRecord) async {
    Map<String, dynamic> rowData = _record2Row(currentRecord);
    int n = await mDB.update(_bpRecTbl, rowData,
        where: "id = ?", whereArgs: [currentRecord.id]);
    return n;
  }
}
