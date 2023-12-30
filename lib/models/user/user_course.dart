class UserCourse {
  String? id;
  String? name;

  UserCourse({
    this.id,
    this.name,
  });

  UserCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
