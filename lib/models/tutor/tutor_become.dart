import 'dart:io';

class TutorBecome {
  String? name;
  String? country;
  String? birthday;
  String? education;
  String? experience;
  String? interests;
  String? profession;
  String? bio;
  String? languages;
  String? targetStudent;
  String? specialities;
  File? avatar;
  File? video;
  int? price;
  List<Map<String, String>>?
      certificateMapping; // [{"certificateFileName": "certificate1.jpg", "certificateType": "IELTS"}]
  List<File>? certificate;

  TutorBecome({
    this.name,
    this.country,
    this.birthday,
    this.education,
    this.experience,
    this.interests,
    this.profession,
    this.bio,
    this.languages,
    this.targetStudent,
    this.specialities,
    this.avatar,
    this.video,
    this.price,
    this.certificateMapping,
    this.certificate,
  });

  TutorBecome.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    birthday = json['birthday'];
    education = json['education'];
    experience = json['experience'];
    interests = json['interests'];
    profession = json['profession'];
    bio = json['bio'];
    languages = json['languages'];
    targetStudent = json['targetStudent'];
    specialities = json['specialities'];
    avatar = json['avatar'];
    video = json['video'];
    price = json['price'];
    certificateMapping = json['certificateMapping'];
    certificate = json['certificate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['birthday'] = birthday;
    data['education'] = education;
    data['experience'] = experience;
    data['interests'] = interests;
    data['profession'] = profession;
    data['bio'] = bio;
    data['languages'] = languages;
    data['targetStudent'] = targetStudent;
    data['specialities'] = specialities;
    data['avatar'] = avatar;
    data['video'] = video;
    data['price'] = price;
    data['certificateMapping'] = certificateMapping;
    data['certificate'] = certificate;
    return data;
  }
}
