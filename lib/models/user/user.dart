import 'package:lettutor/models/misc/learn_topic.dart';
import 'package:lettutor/models/misc/test_preparation.dart';
import 'package:lettutor/models/user/user_course.dart';
import 'package:lettutor/models/user/wallet.dart';

class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  Wallet? walletInfo;
  List<String>? coursesId;
  String? requireNote;
  String? level;
  List<LearnTopic>? learnTopics;
  List<TestPreparation>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  String? studySchedule;
  bool? canSendMessage;
  List<UserCourse>? courses;

  User({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.walletInfo,
    this.coursesId,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
    this.courses,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    roles = json['roles']?.cast<String>();
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    walletInfo =
        json['walletInfo'] != null ? Wallet.fromJson(json['walletInfo']) : null;
    coursesId = json['courses']?.cast<String>();
    requireNote = json['requireNote'];
    level = json['level'];
    learnTopics = json['learnTopics']
        ?.map<LearnTopic>((learnTopic) => LearnTopic.fromJson(learnTopic))
        .toList();
    testPreparations = json['testPreparations']
        ?.map<TestPreparation>(
            (testPreparation) => TestPreparation.fromJson(testPreparation))
        .toList();
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    courses = json['courses']
        ?.map<UserCourse>((userCourse) => UserCourse.fromJson(userCourse))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['avatar'] = avatar;
    data['country'] = country;
    data['phone'] = phone;
    data['roles'] = roles;
    data['language'] = language;
    data['birthday'] = birthday;
    data['isActivated'] = isActivated;
    data['walletInfo'] = walletInfo?.toJson();
    data['courses'] = coursesId;
    data['requireNote'] = requireNote;
    data['level'] = level;
    data['learnTopics'] =
        learnTopics?.map((learnTopic) => learnTopic.toJson()).toList();
    data['testPreparations'] = testPreparations
        ?.map((testPreparation) => testPreparation.toJson())
        .toList();
    data['isPhoneActivated'] = isPhoneActivated;
    data['timezone'] = timezone;
    data['studySchedule'] = studySchedule;
    data['canSendMessage'] = canSendMessage;
    data['courses'] =
        courses?.map((userCourse) => userCourse.toJson()).toList();
    return data;
  }
}