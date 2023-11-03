class Course {
  const Course(
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.level,
    this.topics,
  );

  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final String? level;
  final List<String>? topics;
}
