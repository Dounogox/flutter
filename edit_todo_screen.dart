import 'package:flutter/material.dart';
import 'package:app_todo_list/models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final ToDo toDo;

  const EditTodoScreen({super.key, required this.toDo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Gán dữ liệu sẵn từ todo được chọn truyền vào
    _titleController = TextEditingController(text: widget.toDo.title);
    _descriptionController =
        TextEditingController(text: widget.toDo.description ?? "");
    _selectedDate = widget.toDo.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chỉnh sửa công việc")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Tiêu đề",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Mô tả",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? "Hạn: ${_selectedDate!.toLocal().toString().split(' ')[0]}"
                        : "Chưa chọn hạn",
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDueDate,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // UI demo: chỉ đóng màn hình lại
                Navigator.pop(context);
              },
              child: const Text("Cập nhật"),
            ),
          ],
        ),
      ),
    );
  }
}
