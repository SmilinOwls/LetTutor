import 'package:lettutor/models/user/speciality.dart';

class TestPreparation implements Speciality {
  @override
  int? id;

  @override
  String? key;

  @override
  String? name;

  TestPreparation({
    this.id,
    this.key,
    this.name,
  });

  TestPreparation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'name': name,
      };
}
