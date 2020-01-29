import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

final String dbName = 'places.db';
final String tableName = 'user_places';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnImage = 'image';

class DBHelper {
  static Future<Database> database() async{
    final dbPath = await getDatabasesPath();
    
    return openDatabase(
      path.join(dbPath, dbName),
      version: 1,
      onCreate: (db, vers) async {
        await db.execute(
            'CREATE TABLE $tableName ($columnId TEXT PRIMARY KEY, $columnTitle TEXT NOT NULL, $columnImage TEXT)');
      },
    );
  }
  static Future<dynamic> insert(Map<String, Object> data) async {
    Database db = await DBHelper.database();
    var id = await db.insert(tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Map<String, dynamic>>> getData()async {
    Database db = await DBHelper.database();
    return db.query(tableName);
  }
}
