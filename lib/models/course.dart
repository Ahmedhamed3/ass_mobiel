import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String userId;
  final DateTime? createdAt;

  factory Course.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final timestamp = data['createdAt'] as Timestamp?;

    return Course(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      createdAt: timestamp?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}