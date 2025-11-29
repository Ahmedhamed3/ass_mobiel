import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';

  class CourseService {
  CourseService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

    final FirebaseFirestore _db;


Stream<List<Course>> coursesForUser(String uid) {
    return _db
        .collection('courses')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(Course.fromDoc).toList(),
        );
  }

  Future<void> addCourse({
    required String title,
    required String description,
    required String userId,
  }) async {
    final course = Course(
      id: '',
      title: title,
      description: description,
      userId: userId,
      createdAt: null,
    );
  
await _db.collection('courses').add(course.toMap());
  }
}