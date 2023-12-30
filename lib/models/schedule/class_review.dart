import 'package:lettutor/models/schedule/lesson_status.dart';

class ClassReview {
  String? bookingId;
  int? lessonStatusId;
  String? book;
  String? unit;
  String? lesson;
  dynamic page;
  String? lessonProgress;
  int? behaviorRating;
  String? behaviorComment;
  int? listeningRating;
  String? listeningComment;
  int? speakingRating;
  String? speakingComment;
  int? vocabularyRating;
  String? vocabularyComment;
  String? homeworkComment;
  String? overallComment;
  LessonStatus? lessonStatus;

  ClassReview({
    this.bookingId,
    this.lessonStatusId,
    this.book,
    this.unit,
    this.lesson,
    this.page,
    this.lessonProgress,
    this.behaviorRating,
    this.behaviorComment,
    this.listeningRating,
    this.listeningComment,
    this.speakingRating,
    this.speakingComment,
    this.vocabularyRating,
    this.vocabularyComment,
    this.homeworkComment,
    this.overallComment,
    this.lessonStatus,
  });

  ClassReview.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    lessonStatusId = json['lessonStatusId'];
    book = json['book'];
    unit = json['unit'];
    lesson = json['lesson'];
    page = json['page'];
    lessonProgress = json['lessonProgress'];
    behaviorRating = json['behaviorRating'];
    behaviorComment = json['behaviorComment'];
    listeningRating = json['listeningRating'];
    listeningComment = json['listeningComment'];
    speakingRating = json['speakingRating'];
    speakingComment = json['speakingComment'];
    vocabularyRating = json['vocabularyRating'];
    vocabularyComment = json['vocabularyComment'];
    homeworkComment = json['homeworkComment'];
    overallComment = json['overallComment'];
    lessonStatus = LessonStatus.fromJson(json['lessonStatus']);
  }

  Map<String, dynamic> toJson() => {
        'bookingId': bookingId,
        'lessonStatusId': lessonStatusId,
        'book': book,
        'unit': unit,
        'lesson': lesson,
        'page': page,
        'lessonProgress': lessonProgress,
        'behaviorRating': behaviorRating,
        'behaviorComment': behaviorComment,
        'listeningRating': listeningRating,
        'listeningComment': listeningComment,
        'speakingRating': speakingRating,
        'speakingComment': speakingComment,
        'vocabularyRating': vocabularyRating,
        'vocabularyComment': vocabularyComment,
        'homeworkComment': homeworkComment,
        'overallComment': overallComment,
        'lessonStatus': lessonStatus?.toJson(),
      };
}
