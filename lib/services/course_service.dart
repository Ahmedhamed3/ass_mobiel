import 'package:cloud_firestore/cloud_firestore.dart';
class Course {
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    this.createdAt,
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

    Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
}

class CourseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
    Stream<List<Course>> coursesForUser(String uid) {
    return _db
        .collection('courses')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Course.fromDoc(doc)).toList());
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  
}