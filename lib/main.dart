import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/auth/forgot/forgot_password_screen.dart';
import 'package:lettutor/features/auth/login/login_screen.dart';
import 'package:lettutor/features/auth/register/register_screen.dart';
import 'package:lettutor/features/courses/course_detail/course_detail_screen.dart';
import 'package:lettutor/features/navigation/navigation_bar.dart';
import 'package:lettutor/features/tutor/tutor_become/tutor_become_screen.dart';
import 'package:lettutor/features/tutor/tutor_detail/tutor_detail_screen.dart';
import 'package:lettutor/features/account/user/profile/profile_screen.dart';
import 'package:lettutor/features/video_call/video_call_screen.dart';
import 'package:lettutor/providers/language/language_provider.dart';
import 'package:lettutor/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const LetTutor(),
    ),
  );
}

class LetTutor extends StatelessWidget {
  const LetTutor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LetTutor',
        theme: Provider.of<ThemeProvider>(context).getThemeMode(),
        home: const LoginScreen(),
        routes: {
          Routes.login: (context) => const LoginScreen(),
          Routes.register: (context) => const RegisterScreen(),
          Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
          Routes.main: (context) => const TabBarNavigator(),
          Routes.tutorDetail: (context) => const TutorDetailScreen(),
          Routes.tutorBecome: (context) => const TutorBecomeScreen(),
          Routes.courseDetail: (context) => const CourseDetailScreen(),
          Routes.userProfile: (context) => const ProfileScreen(),
          Routes.videoCall: (context) => const VideoCallScreen(),
        });
  }
}
