import 'package:lettutor/constants/dto/courses/course_topic.dart';

class Course {
  const Course(
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.level,
    this.topics,
    this.reason,
    this.purpose,
  );

  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final String? level;
  final List<CourseTopic>? topics;
  final String? reason;
  final String? purpose;
}
