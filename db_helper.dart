import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:app_todo_list/models/todo.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("todos.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Tạo bảng todos
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        dueDate TEXT,
        isCompleted INTEGER NOT NULL
      )
    ''');

    await db.insert('todos', {
      'title': 'Học lập trình Flutter',
      'description': 'Xem video và đọc giáo trình',
      'dueDate': '2025-08-26',
      'isCompleted': 0
    });

    await db.insert('todos', {
      'title': 'Học ngôn ngữ lập trình Dart',
      'description': 'Đọc giáo trình',
      'dueDate': '2025-08-15',
      'isCompleted': 0,
    });
  }

  // ================= CRUD =================

  // Thêm mới
  Future<int> insertTodo(ToDo todo) async {
    final db = await database;
    return await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Lấy tất cả
  Future<List<ToDo>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return ToDo.fromMap(maps[i]);
    });
  }

  // Cập nhật
  Future<int> updateTodo(ToDo todo) async {
    final db = await database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  // Xóa
  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
