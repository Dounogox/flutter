import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final ToDo toDo;

  const TodoDetailScreen({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết đầu việc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            Text(
              toDo.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Mô tả
            Text(
              toDo.description ?? "Không có mô tả",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Ngày hết hạn
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(
                  toDo.dueDate != null
                      ? "Hạn: ${toDo.dueDate}"
                      : "Không có hạn",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Trạng thái
            Row(
              children: [
                Icon(
                  toDo.isCompleted == 1
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: toDo.isCompleted == 1 ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  toDo.isCompleted == 1
                      ? "Đã hoàn thành"
                      : "Chưa hoàn thành",
                  style: TextStyle(
                    fontSize: 14,
                    color: toDo.isCompleted == 1 ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
