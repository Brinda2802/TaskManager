class Task {
  String id;
  String title;
  String description;
 // DateTime createdAt;

  Task({required this.id, required this.title, required this.description, });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
   // 'createdAt': createdAt.toIso8601String(),
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
   // createdAt: DateTime.parse(json['createdAt']),
  );
}
