import 'package:lettutor/models/courses/ebook/ebook_category.dart';

class EBook {

  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? level;
  final String? reason;
  final bool? visible;
  final String? createdAt;
  final String? updatedAt;
  final List<EBookCategory>? categories;
  final bool? isPrivate;
  final String? createdBy;
  final String? fileUrl;
  
  EBook({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.isPrivate,
    this.createdBy,
    this.fileUrl,
  });

  factory EBook.fromJson(Map<String, dynamic> json) {
    return EBook(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      level: json['level'] as String?,
      reason: json['reason'] as String?,
      visible: json['visible'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => EBookCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPrivate: json['isPrivate'] as bool?,
      createdBy: json['createdBy'] as String?,
      fileUrl: json['fileUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'level': level,
      'reason': reason,
      'visible': visible,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'categories': categories?.map((e) => e.toJson()).toList(),
      'isPrivate': isPrivate,
      'createdBy': createdBy,
      'fileUrl': fileUrl,
    };
  }
}
