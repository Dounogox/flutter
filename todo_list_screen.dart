import 'package:flutter/material.dart';

import 'package:app_todo_list/controllers/todo_controller.dart';
import 'package:app_todo_list/models/todo.dart';
import 'package:app_todo_list/views/add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoController _controller = TodoController();
  List<ToDo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _controller.getTodos();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  Future<void> _deleteTodo(int id) async {
    await _controller.deleteTodo(id);
    _loadTodos(); // reload sau khi xóa
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Xóa thành công")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý công việc"), centerTitle: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _todos.isEmpty
          ? const Center(child: Text("Chưa có công việc cần làm"))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  leading: Icon(
                    todo.isCompleted == 1
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: todo.isCompleted == 1 ? Colors.green : Colors.grey,
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: todo.dueDate != null
                      ? Text("Hạn: ${todo.dueDate}")
                      : null,
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.delete, color: Colors.red),
                  //   onPressed: () => _deleteTodo(todo.id!),
                  // ),
                  onTap: () {
                    // sau này có thể chuyển sang TodoDetailScreen
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTodoScreen()),
          );
          if (result == true) {
            _loadTodos(); // Gọi lại hàm load trong TodoListScreen để refresh
          }
        },
      ),
    );
  }
}
