import 'package:lettutor/models/courses/course.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/models/courses/ebook.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';

const tutorNationalities = [
  'Foreign Tutor',
  'Vietnamese Tutor',
  'Native English Tutor'
];

const filteredTags = [
  'All',
  'English for kids',
  'English for Business',
  'Conversational',
  'STARTERS',
  'MOVERS',
  'FLYERS',
  'KET',
  'PET',
  'IELTS',
  'TOEFL',
  'TOEIC'
];

const tutorLevels = [
  'Pre A1 (Beginner)',
  'A1 (Higher Beginner)',
  'A2 (Pre-Intermediate)',
  'B1 (Intermediate)',
  'B2 (Upper-Intermediate)',
  'C1 (Advanced)',
  'C2 (Proficiency)',
];

const subjects = [
  'English for kids',
  'English for Business',
  'Conversational',
];

const testPreparations = [
  'STARTERS',
  'MOVERS',
  'FLYERS',
  'KET',
  'PET',
  'IELTS',
  'TOEFL',
  'TOEIC'
];

const courseTopics = [
  'The Internet',
  'Artificial Intelligence (AI)',
  'Social Media',
  'Internet Privacy',
  'Live Streaming',
  'Coding',
  'Technology Transforming Healthcare',
  'Smart Home Technology',
  'Remote Work - A Dream Job?',
];

const courseHours = [
  '00:00 - 00:25',
  '00:30 - 00:55',
  '01:00 - 01:25',
  '01:30 - 01:55',
  '02:00 - 02:25',
  '02:30 - 02:55',
  '03:00 - 03:25',
  '03:30 - 03:55',
  '04:00 - 04:25',
  '04:30 - 04:55',
  '05:00 - 05:25',
  '05:30 - 05:55',
  '06:00 - 06:25',
  '06:30 - 06:55',
  '07:00 - 07:25',
  '07:30 - 07:55',
  '08:00 - 08:25',
  '08:30 - 08:55',
  '09:00 - 09:25',
  '09:30 - 09:55',
  '10:00 - 10:25',
  '10:30 - 10:55',
  '11:00 - 11:25',
  '11:30 - 11:55',
  '12:00 - 12:25',
  '12:30 - 12:55',
  '13:00 - 13:25',
  '13:30 - 13:55',
  '14:00 - 14:25',
  '14:30 - 14:55',
  '15:00 - 15:25',
  '15:30 - 15:55',
  '16:00 - 16:25',
  '16:30 - 16:55',
  '17:00 - 17:25',
  '17:30 - 17:55',
  '18:00 - 18:25',
  '18:30 - 18:55',
  '19:00 - 19:25',
  '19:30 - 19:55',
  '20:00 - 20:25',
  '20:30 - 20:55',
  '21:00 - 21:25',
  '21:30 - 21:55',
  '22:00 - 22:25',
  '22:30 - 22:55',
  '23:00 - 23:25',
  '23:30 - 23:55',
];

const languageList = [
  Language('1', 'English', 'assets/language/english.svg'),
  Language('2', 'Vietnamese', 'assets/language/vietnamese.svg')
];

const tutorFeedback = [
  TutorFeedback('1', 'Phhai123', 'Tutor teaches very great lessons', 5),
  TutorFeedback('2', 'Nameless User', '5 stars for amazing endeavors!', 5),
  TutorFeedback('3', 'Phhai321', 'Very impressive', 5),
  TutorFeedback(
      '4', 'hailepham212', 'Cool lessons. Hope to see you again..', 4),
];

const courses = [
  Course(
      "1",
      "Life in the Internet Age",
      "assets/course//traveling/traveling_course_01.jpeg",
      "Let's discuss how technology is changing the way we live",
      "Intermediate"),
  Course(
      "2",
      "Caring for Our Planet",
      "assets/course/traveling/traveling_course_02.jpeg",
      "Let's discuss our relationship as humans with our planet, Earth",
      "Intermediate"),
  Course(
    "3",
    "Healthy Mind, Healthy Body",
    "assets/course/traveling/traveling_course_03.jpeg",
    "Let's discuss the many aspects of living a long, happy life",
    "Intermediate",
  ),
  Course(
      "4",
      "Movies and Television",
      "assets/course/traveling/traveling_course_04.jpeg",
      "Let's discuss our preferences and habits surrounding movies and television shows",
      "Beginner"),
  Course(
    "5",
    "Raising Children",
    "assets/course/traveling/traveling_course_05.jpeg",
    "Let's discuss raising children and practice using English for common parenting situations",
    "Intermediate",
  ),
  Course(
    "6",
    "The Olympics",
    "assets/course/traveling/traveling_course_06.jpeg",
    "Let’s practice talking about the Olympics, the biggest sports festival on earth!",
    "Advanced",
  ),
];

const teachers = [
  Tutor(
    '1',
    'assets/avatar/tutor/keegan_tutor_avatar.jpeg',
    'Keegan',
    'Tunisia',
    'I am passionate about running and fitness, '
        'I often compete in trail/mountain running events and I love pushing myself. '
        'I am training to one day take part in ultra-endurance events. '
        'I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. '
        'My most memorable life experience would be living in and traveling around Southeast Asia.',
    'BA',
    ['English'],
    [
      'English for kids',
      'English for Business',
      'Conversational',
      'IELTS',
      'TOEFL',
      'TOEIC'
    ],
    'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
    'I have more than 10 years of teaching english experience',
    4.0,
    122,
  ),
  Tutor(
      '2',
      'assets/avatar/tutor/april_baldo_tutor_avatar.jpeg',
      'April Baldo',
      'Philippines',
      'Hello! My name is April Baldo, you can just call me Teacher April. '
          'I am an English teacher and currently teaching in senior high school. '
          'I have been teaching grammar and literature for almost 10 years. '
          'I am fond of reading and teaching literature as one way of knowing one’s '
          'beliefs and culture. I am friendly and full of positivity. '
          'I love teaching because I know each student has something to bring on. '
          'Molding them to become an individual is a great success.',
      'Earth, Vegeta planet',
      ['English', 'Japanese'],
      [
        'English for Business',
        'IELTS',
        'PET',
        'KET',
      ],
      'FIghting',
      '7 years of English tutor',
      4.0,
      23),
  Tutor(
      '3',
      'Jill Leano',
      'assets/avatar/tutor/jill_leano_tutor_avatar.jpeg',
      'Philippines',
      "Hi, My name is Jill I am an experienced English Teacher from Philippine. "
          "I would like to share my enthusiasm with the learners in this platform. "
          "I've been working with diverse learners of all levels for many years. "
          "I am greatly passionate about about profession. I love teaching "
          "because I can help others improve their skills and it gives me joy and "
          "excitement meeting different learners around the world. "
          "In my class I worked with wonderful enthusiasm and positivity, "
          "and I'm happy to focus on my learner's goal.",
      'Earth, Vegeta planet',
      ['English'],
      ['English for kids', 'English for Business', 'TOEFL', 'TOEIC'],
      'English, Japansese',
      '5 years in education',
      4,
      9),
];

const ebooks = [
  EBook(
    '1',
    'Family and Friends 1',
    'assets/ebook/family_and_friends_ebook.jpeg',
    "For kids who can read pretty well, get ready for compound sentences and...",
    'Upper-Beginner',
  ),
  EBook(
    '2',
    'Family and Friends 2',
    'assets/ebook/family_and_friends_ebook.jpeg',
    "For kids who can read pretty well, get ready for compound sentences and...",
    'Upper-Beginner',
  ),
  EBook(
    '3',
    'Family and Friends 3',
    'assets/ebook/family_and_friends_ebook.jpeg',
    "For kids who can read pretty well, get ready for compound sentences and...",
    'Upper-Beginner',
  ),
  EBook(
    '4',
    'Everybody Up',
    'assets/ebook/everybody_up_ebook.jpeg',
    "For: kids who want to learn English through pictures, pick up simple...",
    'Beginner',
  ),
  EBook(
    '5',
    'Cambridge Storyfun For Starter',
    'assets/ebook/storyfun_ebook.jpeg',
    "For kids who can handle single words and simple sentences with assistance.",
    'Beginner',
  ),
  EBook(
    '6',
    'assets/ebook/new_headway_ebook.jpeg',
    'New Headway Elementary',
    "For teenagers who want to form a grammatical background as well as...",
    'Beginner',
  ),
  EBook(
    '7',
    'English World ',
    'assets/english_world_ebook.jpg',
    "For kids who are able to pick up simple sounds, letters, words and learn new...",
    'Beginner',
  ),
];
