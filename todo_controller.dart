import '../database//db_helper.dart';
import '../models/todo.dart';

class TodoController {
  final DBHelper _dbHelper = DBHelper();

  // Lấy danh sách tất cả ToDo
  Future<List<ToDo>> getTodos() async {
    return await _dbHelper.getTodos();
  }

  // Thêm mới ToDo
  Future<bool> addTodo(ToDo todo) async {
    try {
      await _dbHelper.insertTodo(todo);
      return true;
    } catch (e) {
      print("Lỗi khi thêm ToDo: $e");
      return false;
    }
  }

  // Cập nhật ToDo
  Future<bool> updateTodo(ToDo todo) async {
    try {
      await _dbHelper.updateTodo(todo);
      return true;
    } catch (e) {
      print("Lỗi khi cập nhật ToDo: $e");
      return false;
    }
  }

  // Xóa ToDo
  Future<bool> deleteTodo(int id) async {
    try {
      await _dbHelper.deleteTodo(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa ToDo: $e");
      return false;
    }
  }
}
