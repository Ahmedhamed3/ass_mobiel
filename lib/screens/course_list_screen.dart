import 'package:flutter/material.dart';

import '../models/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/course_service.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.microtask(() =>
          Navigator.pushNamedAndRemoveUntil(context, '/register', (_) => false));
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () async {
              await AuthService.instance.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/register', (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/add-course'),
        icon: const Icon(Icons.add),
        label: const Text('Add course'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: StreamBuilder<List<Course>>(
          stream: CourseService().coursesForUser(user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong: ${snapshot.error}'),
              );
            }

            final courses = snapshot.data ?? [];

            if (courses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.menu_book, size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(
                      'No courses yet',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    const Text('Add your first course to get started.'),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemCount: courses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CourseCard(course: courses[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
