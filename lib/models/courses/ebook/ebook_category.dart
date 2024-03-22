import 'package:lettutor/models/courses/course/course_category.dart';

class EBookCategory extends CourseCategory {
  EBookCategory({
    super.id,
    super.title,
    super.description,
    super.key,
    super.createdAt,
    super.updatedAt,
  });

  EBookCategory.fromJson(super.json) : super.fromJson();
}
