import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TaskModel {
  // final String id;
  final String uid;
  final Timestamp createdAt;
  String status;
  final String title;
  final String description;

  TaskModel({
    // required this.id,
    required this.uid,
    required this.createdAt,
    required this.status,
    required this.title,
    required this.description,
  });

  TaskModel copyWith({
    // String? id,
    String? uid,
    Timestamp? createdAt,
    String? status,
    String? title,
    String? description,
  }) {
    return TaskModel(
      // id: id ?? this.id,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  String get formattedDate =>
      DateFormat('MMM dd, yyyy').format(createdAt.toDate());
}
