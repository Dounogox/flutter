class ToDo {
  int? id;
  String title;
  String? description;
  DateTime? dueDate;
  int isCompleted; // 0 = chưa xong, 1 = đã xong

  ToDo({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.isCompleted = 0,
  });

  // Chuyển từ Map (SQLite) sang ToDo object
  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      isCompleted: map['isCompleted'] ?? 0,
    );
  }

  // Chuyển từ ToDo object sang Map (để lưu SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
