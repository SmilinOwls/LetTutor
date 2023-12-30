class LessonStatus {
  final int? id;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LessonStatus({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LessonStatus.fromJson(Map<String, dynamic> json) => LessonStatus(
        id: json['id'],
        status: json['status'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
