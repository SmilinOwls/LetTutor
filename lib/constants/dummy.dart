import 'package:lettutor/models/courses/course.dart';
import 'package:lettutor/models/courses/course_topic.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/models/courses/ebook.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';

const tutorNationalities = [
  'Foreign Tutor',
  'Vietnamese Tutor',
  'Native English Tutor'
];

const tutorSpecialities = [
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

const desiredLearningContent = [
  {
    'name': 'Subjects',
    'detail': subjects,
  },
  {
    'name': 'Test Preparations',
    'detail': testPreparations,
  },
];

const tutorBookingHours = [
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

const countryList = {
  "AF": "Afghanistan",
  "AL": "Albania",
  "DZ": "Algeria",
  "AS": "American Samoa",
  "AD": "Andorra",
  "AO": "Angola",
  "AI": "Anguilla",
  "AQ": "Antarctica",
  "AG": "Antigua and Barbuda",
  "AR": "Argentina",
  "AM": "Armenia",
  "AW": "Aruba",
  "AU": "Australia",
  "AT": "Austria",
  "AZ": "Azerbaijan",
  "BS": "Bahamas (the)",
  "BH": "Bahrain",
  "BD": "Bangladesh",
  "BB": "Barbados",
  "BY": "Belarus",
  "BE": "Belgium",
  "BZ": "Belize",
  "BJ": "Benin",
  "BM": "Bermuda",
  "BT": "Bhutan",
  "BO": "Bolivia (Plurinational State of)",
  "BQ": "Bonaire, Sint Eustatius and Saba",
  "BA": "Bosnia and Herzegovina",
  "BW": "Botswana",
  "BV": "Bouvet Island",
  "BR": "Brazil",
  "IO": "British Indian Ocean Territory (the)",
  "BN": "Brunei Darussalam",
  "BG": "Bulgaria",
  "BF": "Burkina Faso",
  "BI": "Burundi",
  "CV": "Cabo Verde",
  "KH": "Cambodia",
  "CM": "Cameroon",
  "CA": "Canada",
  "KY": "Cayman Islands (the)",
  "CF": "Central African Republic (the)",
  "TD": "Chad",
  "CL": "Chile",
  "CN": "China",
  "CX": "Christmas Island",
  "CC": "Cocos (Keeling) Islands (the)",
  "CO": "Colombia",
  "KM": "Comoros (the)",
  "CD": "Congo (the Democratic Republic of the)",
  "CG": "Congo (the)",
  "CK": "Cook Islands (the)",
  "CR": "Costa Rica",
  "HR": "Croatia",
  "CU": "Cuba",
  "CW": "Curaçao",
  "CY": "Cyprus",
  "CZ": "Czechia",
  "CI": "Côte d'Ivoire",
  "DK": "Denmark",
  "DJ": "Djibouti",
  "DM": "Dominica",
  "DO": "Dominican Republic (the)",
  "EC": "Ecuador",
  "EG": "Egypt",
  "SV": "El Salvador",
  "GQ": "Equatorial Guinea",
  "ER": "Eritrea",
  "EE": "Estonia",
  "SZ": "Eswatini",
  "ET": "Ethiopia",
  "FK": "Falkland Islands (the) [Malvinas]",
  "FO": "Faroe Islands (the)",
  "FJ": "Fiji",
  "FI": "Finland",
  "FR": "France",
  "GF": "French Guiana",
  "PF": "French Polynesia",
  "TF": "French Southern Territories (the)",
  "GA": "Gabon",
  "GM": "Gambia (the)",
  "GE": "Georgia",
  "DE": "Germany",
  "GH": "Ghana",
  "GI": "Gibraltar",
  "GR": "Greece",
  "GL": "Greenland",
  "GD": "Grenada",
  "GP": "Guadeloupe",
  "GU": "Guam",
  "GT": "Guatemala",
  "GG": "Guernsey",
  "GN": "Guinea",
  "GW": "Guinea-Bissau",
  "GY": "Guyana",
  "HT": "Haiti",
  "HM": "Heard Island and McDonald Islands",
  "VA": "Holy See (the)",
  "HN": "Honduras",
  "HK": "Hong Kong",
  "HU": "Hungary",
  "IS": "Iceland",
  "IN": "India",
  "ID": "Indonesia",
  "IR": "Iran (Islamic Republic of)",
  "IQ": "Iraq",
  "IE": "Ireland",
  "IM": "Isle of Man",
  "IL": "Israel",
  "IT": "Italy",
  "JM": "Jamaica",
  "JP": "Japan",
  "JE": "Jersey",
  "JO": "Jordan",
  "KZ": "Kazakhstan",
  "KE": "Kenya",
  "KI": "Kiribati",
  "KP": "Korea (the Democratic People's Republic of)",
  "KR": "Korea (the Republic of)",
  "KW": "Kuwait",
  "KG": "Kyrgyzstan",
  "LA": "Lao People's Democratic Republic (the)",
  "LV": "Latvia",
  "LB": "Lebanon",
  "LS": "Lesotho",
  "LR": "Liberia",
  "LY": "Libya",
  "LI": "Liechtenstein",
  "LT": "Lithuania",
  "LU": "Luxembourg",
  "MO": "Macao",
  "MG": "Madagascar",
  "MW": "Malawi",
  "MY": "Malaysia",
  "MV": "Maldives",
  "ML": "Mali",
  "MT": "Malta",
  "MH": "Marshall Islands (the)",
  "MQ": "Martinique",
  "MR": "Mauritania",
  "MU": "Mauritius",
  "YT": "Mayotte",
  "MX": "Mexico",
  "FM": "Micronesia (Federated States of)",
  "MD": "Moldova (the Republic of)",
  "MC": "Monaco",
  "MN": "Mongolia",
  "ME": "Montenegro",
  "MS": "Montserrat",
  "MA": "Morocco",
  "MZ": "Mozambique",
  "MM": "Myanmar",
  "NA": "Namibia",
  "NR": "Nauru",
  "NP": "Nepal",
  "NL": "Netherlands (the)",
  "NC": "New Caledonia",
  "NZ": "New Zealand",
  "NI": "Nicaragua",
  "NE": "Niger (the)",
  "NG": "Nigeria",
  "NU": "Niue",
  "NF": "Norfolk Island",
  "MP": "Northern Mariana Islands (the)",
  "NO": "Norway",
  "OM": "Oman",
  "PK": "Pakistan",
  "PW": "Palau",
  "PS": "Palestine, State of",
  "PA": "Panama",
  "PG": "Papua New Guinea",
  "PY": "Paraguay",
  "PE": "Peru",
  "PH": "Philippines (the)",
  "PN": "Pitcairn",
  "PL": "Poland",
  "PT": "Portugal",
  "PR": "Puerto Rico",
  "QA": "Qatar",
  "MK": "Republic of North Macedonia",
  "RO": "Romania",
  "RU": "Russian Federation",
  "RW": "Rwanda",
  "RE": "Réunion",
  "BL": "Saint Barthélemy",
  "SH": "Saint Helena, Ascension and Tristan da Cunha",
  "KN": "Saint Kitts and Nevis",
  "LC": "Saint Lucia",
  "MF": "Saint Martin (French part)",
  "PM": "Saint Pierre and Miquelon",
  "VC": "Saint Vincent and the Grenadines",
  "WS": "Samoa",
  "SM": "San Marino",
  "ST": "Sao Tome and Principe",
  "SA": "Saudi Arabia",
  "SN": "Senegal",
  "RS": "Serbia",
  "SC": "Seychelles",
  "SL": "Sierra Leone",
  "SG": "Singapore",
  "SX": "Sint Maarten (Dutch part)",
  "SK": "Slovakia",
  "SI": "Slovenia",
  "SB": "Solomon Islands",
  "SO": "Somalia",
  "ZA": "South Africa",
  "GS": "South Georgia and the South Sandwich Islands",
  "SS": "South Sudan",
  "ES": "Spain",
  "LK": "Sri Lanka",
  "SD": "Sudan (the)",
  "SR": "Suriname",
  "SJ": "Svalbard and Jan Mayen",
  "SE": "Sweden",
  "CH": "Switzerland",
  "SY": "Syrian Arab Republic",
  "TW": "Taiwan",
  "TJ": "Tajikistan",
  "TZ": "Tanzania, United Republic of",
  "TH": "Thailand",
  "TL": "Timor-Leste",
  "TG": "Togo",
  "TK": "Tokelau",
  "TO": "Tonga",
  "TT": "Trinidad and Tobago",
  "TN": "Tunisia",
  "TR": "Turkey",
  "TM": "Turkmenistan",
  "TC": "Turks and Caicos Islands (the)",
  "TV": "Tuvalu",
  "UG": "Uganda",
  "UA": "Ukraine",
  "AE": "United Arab Emirates (the)",
  "GB": "United Kingdom of Great Britain and Northern Ireland (the)",
  "UM": "United States Minor Outlying Islands (the)",
  "US": "United States of America (the)",
  "UY": "Uruguay",
  "UZ": "Uzbekistan",
  "VU": "Vanuatu",
  "VE": "Venezuela (Bolivarian Republic of)",
  "VN": "Viet Nam",
  "VG": "Virgin Islands (British)",
  "VI": "Virgin Islands (U.S.)",
  "WF": "Wallis and Futuna",
  "EH": "Western Sahara",
  "YE": "Yemen",
  "ZM": "Zambia",
  "ZW": "Zimbabwe",
  "AX": "Åland Islands"
};

const studentLevels = {
  "Pre A1": 'Pre A1 (Beginner)',
  "A1": 'A1 (Higher Beginner)',
  "A2": 'A2 (Pre-Intermediate)',
  "B1": 'B1 (Intermediate)',
  "B2": 'B2 (Upper-Intermediate)',
  "C1": 'C1 (Advanced)',
  "C2": 'C2 (Proficiency)',
  "Upper A1": 'Upper A1 (High Beginner)',
  "Upper A2": 'Upper A2 (Pre Intermediate)',
};

const certificateLevels = {
  'TOEIC': 'TOEIC',
  'IELTS': 'IELTS',
  'TOEFL': 'TOEFL',
  'Graduate Certificate': 'Graduate Certificate',
  'TEST': 'TEST',
  'TESTOL': 'TESTOL',
  'Other': 'Other'
};

const studentOverallLevels = ['Beginner', 'Intermediate', 'Advanced'];

const courseTopics = [
  CourseTopic(
    '1',
    'The Internet',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe%20Internet.pdf',
  ),
  CourseTopic(
    '2',
    'Artificial Intelligence (AI)',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileArtificial%20Intelligence%20(AI).pdf',
  ),
  CourseTopic(
    '3',
    'Social Media',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial%20Media.pdf',
  ),
  CourseTopic(
    '4',
    'Internet Privacy',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial%20Media.pdf',
  ),
  CourseTopic(
    '5',
    'Live Streaming',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLive%20Streaming.pdf',
  ),
  CourseTopic(
    '6',
    'Coding',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCoding.pdf',
  ),
  CourseTopic(
    '7',
    'Technology Transforming Healthcare',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileTechnology%20Transforming%20Healthcare.pdf',
  ),
  CourseTopic(
    '8',
    'Smart Home Technology',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSmart%20Home%20Technology.pdf',
  ),
  CourseTopic(
    '9',
    'Remote Work - A Dream Job?',
    'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileRemote%20Work%20-%20A%20Dream%20Job.pdf',
  ),
];

const languageList = [
  Language('en', 'English', 'assets/language/english.svg'),
  Language('vi', 'Vietnamese', 'assets/language/vietnamese.svg'),
];

const tutorFeedback = [
  TutorFeedback(
    '1',
    'Phhai123',
    'Tutor teaches very great lessons',
    5,
    '2023-10-28',
  ),
  TutorFeedback(
    '2',
    'Nameless User',
    '5 stars for amazing endeavors!',
    5,
    '2023-10-28',
  ),
  TutorFeedback(
    '3',
    'Phhai321',
    'Very impressive',
    5,
    '2023-10-28',
  ),
  TutorFeedback(
    '4',
    'hailepham212',
    'Cool lessons. Hope to see you again..',
    4,
    '2023-10-28',
  ),
];

const courses = [
  Course(
      "1",
      "Life in the Internet Age",
      "assets/course/traveling/traveling_course_01.jpeg",
      "Let's discuss how technology is changing the way we live",
      "Intermediate",
      courseTopics,
      "Our world is rapidly changing thanks to new technology, and the vocabulary"
          "needed to discuss modern life is evolving almost daily. In this course"
          "you will learn the most up-to-date terminology from expertly crafted lessons"
          "as well from your native-speaking tutor.",
      "You will learn vocabulary related to timely topics like remote work,"
          "artificial intelligence, online privacy, and more. In addition to discussion questions,"
          "you will practice intermediate level speaking tasks such as using data to describe trends."),
  Course(
    "2",
    "Caring for Our Planet",
    "assets/course/traveling/traveling_course_02.jpeg",
    "Let's discuss our relationship as humans with our planet, Earth",
    "Intermediate",
    courseTopics,
    "Our world is rapidly changing thanks to new technology, and the vocabulary"
        "needed to discuss modern life is evolving almost daily. In this course"
        "you will learn the most up-to-date terminology from expertly crafted lessons"
        "as well from your native-speaking tutor.",
    "You will learn vocabulary related to timely topics like remote work,"
        "artificial intelligence, online privacy, and more. In addition to discussion questions,"
        "you will practice intermediate level speaking tasks such as using data to describe trends.",
  ),
  Course(
    "3",
    "Healthy Mind, Healthy Body",
    "assets/course/traveling/traveling_course_03.jpeg",
    "Let's discuss the many aspects of living a long, happy life",
    "Intermediate",
    courseTopics,
    "Our world is rapidly changing thanks to new technology, and the vocabulary"
        "needed to discuss modern life is evolving almost daily. In this course"
        "you will learn the most up-to-date terminology from expertly crafted lessons"
        "as well from your native-speaking tutor.",
    "You will learn vocabulary related to timely topics like remote work,"
        "artificial intelligence, online privacy, and more. In addition to discussion questions,"
        "you will practice intermediate level speaking tasks such as using data to describe trends.",
  ),
  Course(
    "4",
    "Movies and Television",
    "assets/course/traveling/traveling_course_04.jpeg",
    "Let's discuss our preferences and habits surrounding movies and television shows",
    "Beginner",
    courseTopics,
    "Our world is rapidly changing thanks to new technology, and the vocabulary"
        "needed to discuss modern life is evolving almost daily. In this course"
        "you will learn the most up-to-date terminology from expertly crafted lessons"
        "as well from your native-speaking tutor.",
    "You will learn vocabulary related to timely topics like remote work,"
        "artificial intelligence, online privacy, and more. In addition to discussion questions,"
        "you will practice intermediate level speaking tasks such as using data to describe trends.",
  ),
  Course(
    "5",
    "Raising Children",
    "assets/course/traveling/traveling_course_05.jpeg",
    "Let's discuss raising children and practice using English for common parenting situations",
    "Intermediate",
    courseTopics,
    "Our world is rapidly changing thanks to new technology, and the vocabulary"
        "needed to discuss modern life is evolving almost daily. In this course"
        "you will learn the most up-to-date terminology from expertly crafted lessons"
        "as well from your native-speaking tutor.",
    "You will learn vocabulary related to timely topics like remote work,"
        "artificial intelligence, online privacy, and more. In addition to discussion questions,"
        "you will practice intermediate level speaking tasks such as using data to describe trends.",
  ),
  Course(
    "6",
    "The Olympics",
    "assets/course/traveling/traveling_course_06.jpeg",
    "Let’s practice talking about the Olympics, the biggest sports festival on earth!",
    "Advanced",
    courseTopics,
    "Our world is rapidly changing thanks to new technology, and the vocabulary"
        "needed to discuss modern life is evolving almost daily. In this course"
        "you will learn the most up-to-date terminology from expertly crafted lessons"
        "as well from your native-speaking tutor.",
    "You will learn vocabulary related to timely topics like remote work,"
        "artificial intelligence, online privacy, and more. In addition to discussion questions,"
        "you will practice intermediate level speaking tasks such as using data to describe trends.",
  ),
];

const tutors = [
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
    5.0,
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
    3.0,
    23,
  ),
  Tutor(
    '3',
    'assets/avatar/tutor/jill_leano_tutor_avatar.jpeg',
    'Jill Leano',
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
    4.0,
    9,
  ),
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
    'New Headway Elementary',
    'assets/ebook/new_headway_ebook.jpeg',
    "For teenagers who want to form a grammatical background as well as...",
    'Beginner',
  ),
  EBook(
    '7',
    'English World ',
    'assets/ebook/english_world_ebook.jpeg',
    "For kids who are able to pick up simple sounds, letters, words and learn new...",
    'Beginner',
  ),
];

const worldLanguages = {
  "aa": "Afar",
  "ab": "Abkhazian",
  "ae": "Avestan",
  "af": "Afrikaans",
  "ak": "Akan",
  "am": "Amharic",
  "an": "Aragonese",
  "ar": "Arabic",
  "as": "Assamese",
  "av": "Avaric",
  "ay": "Aymara",
  "az": "Azerbaijani",
  "ba": "Bashkir",
  "be": "Belarusian",
  "bg": "Bulgarian",
  "bh": "Bihari languages",
  "bi": "Bislama",
  "bm": "Bambara",
  "bn": "Bengali",
  "bo": "Tibetan",
  "br": "Breton",
  "bs": "Bosnian",
  "ca": "Catalan",
  "ce": "Chechen",
  "ch": "Chamorro",
  "co": "Corsican",
  "cr": "Cree",
  "cs": "Czech",
  "cu": "Church Slavic",
  "cv": "Chuvash",
  "cy": "Welsh",
  "da": "Danish",
  "de": "German",
  "dv": "Maldivian",
  "dz": "Dzongkha",
  "ee": "Ewe",
  "el": "Greek",
  "en": "English",
  "eo": "Esperanto",
  "es": "Spanish",
  "et": "Estonian",
  "eu": "Basque",
  "fa": "Persian",
  "ff": "Fulah",
  "fi": "Finnish",
  "fj": "Fijian",
  "fo": "Faroese",
  "fr": "French",
  "fy": "Western Frisian",
  "ga": "Irish",
  "gd": "Gaelic",
  "gl": "Galician",
  "gn": "Guarani",
  "gu": "Gujarati",
  "gv": "Manx",
  "ha": "Hausa",
  "he": "Hebrew",
  "hi": "Hindi",
  "ho": "Hiri Motu",
  "hr": "Croatian",
  "ht": "Haitian",
  "hu": "Hungarian",
  "hy": "Armenian",
  "hz": "Herero",
  "ia": "Interlingua",
  "id": "Indonesian",
  "ie": "Interlingue",
  "ig": "Igbo",
  "ii": "Sichuan Yi",
  "ik": "Inupiaq",
  "io": "Ido",
  "is": "Icelandic",
  "it": "Italian",
  "iu": "Inuktitut",
  "ja": "Japanese",
  "jv": "Javanese",
  "ka": "Georgian",
  "kg": "Kongo",
  "ki": "Kikuyu",
  "kj": "Kuanyama",
  "kk": "Kazakh",
  "kl": "Kalaallisut",
  "km": "Central Khmer",
  "kn": "Kannada",
  "ko": "Korean",
  "kr": "Kanuri",
  "ks": "Kashmiri",
  "ku": "Kurdish",
  "kv": "Komi",
  "kw": "Cornish",
  "ky": "Kirghiz",
  "la": "Latin",
  "lb": "Luxembourgish",
  "lg": "Ganda",
  "li": "Limburgan",
  "ln": "Lingala",
  "lo": "Lao",
  "lt": "Lithuanian",
  "lu": "Luba-Katanga",
  "lv": "Latvian",
  "mg": "Malagasy",
  "mh": "Marshallese",
  "mi": "Maori",
  "mk": "Macedonian",
  "ml": "Malayalam",
  "mn": "Mongolian",
  "mr": "Marathi",
  "ms": "Malay",
  "mt": "Maltese",
  "my": "Burmese",
  "na": "Nauru",
  "nb": "Norwegian",
  "nd": "North Ndebele",
  "ne": "Nepali",
  "ng": "Ndonga",
  "nl": "Dutch",
  "nn": "Norwegian",
  "no": "Norwegian",
  "nr": "South Ndebele",
  "nv": "Navajo",
  "ny": "Chichewa",
  "oc": "Occitan",
  "oj": "Ojibwa",
  "om": "Oromo",
  "or": "Oriya",
  "os": "Ossetic",
  "pa": "Panjabi",
  "pi": "Pali",
  "pl": "Polish",
  "ps": "Pushto",
  "pt": "Portuguese",
  "qu": "Quechua",
  "rm": "Romansh",
  "rn": "Rundi",
  "ro": "Romanian",
  "ru": "Russian",
  "rw": "Kinyarwanda",
  "sa": "Sanskrit",
  "sc": "Sardinian",
  "sd": "Sindhi",
  "se": "Northern Sami",
  "sg": "Sango",
  "si": "Sinhala",
  "sk": "Slovak",
  "sl": "Slovenian",
  "sm": "Samoan",
  "sn": "Shona",
  "so": "Somali",
  "sq": "Albanian",
  "sr": "Serbian",
  "ss": "Swati",
  "st": "Sotho, Southern",
  "su": "Sundanese",
  "sv": "Swedish",
  "sw": "Swahili",
  "ta": "Tamil",
  "te": "Telugu",
  "tg": "Tajik",
  "th": "Thai",
  "ti": "Tigrinya",
  "tk": "Turkmen",
  "tl": "Tagalog",
  "tn": "Tswana",
  "to": "Tonga",
  "tr": "Turkish",
  "ts": "Tsonga",
  "tt": "Tatar",
  "tw": "Twi",
  "ty": "Tahitian",
  "ug": "Uighur",
  "uk": "Ukrainian",
  "ur": "Urdu",
  "uz": "Uzbek",
  "ve": "Venda",
  "vi": "Vietnamese",
  "vo": "Volapük",
  "wa": "Walloon",
  "wo": "Wolof",
  "xh": "Xhosa",
  "yi": "Yiddish",
  "yo": "Yoruba",
  "za": "Zhuang",
  "zh": "Chinese",
  "zu": "Zulu"
};
