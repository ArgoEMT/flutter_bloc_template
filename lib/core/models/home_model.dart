import 'dart:convert';

class HomeDataModel {
  HomeDataModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory HomeDataModel.fromJson(String source) =>
      HomeDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory HomeDataModel.fromMap(Map<String, dynamic> map) {
    return HomeDataModel(
      userId: map['userId'].toInt() as int,
      id: map['id'].toInt() as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  final bool completed;
  final int id;
  final String title;
  final int userId;
}
