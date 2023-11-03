import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/auth/forgot/forgot_password_screen.dart';
import 'package:lettutor/features/auth/login/login_screen.dart';
import 'package:lettutor/features/auth/register/register_screen.dart';
import 'package:lettutor/features/courses/course_detail/course_detail_screen.dart';
import 'package:lettutor/features/navigation/navigation_bar.dart';
import 'package:lettutor/features/tutor/tutor_detail/tutor_detail_screen.dart';
import 'package:lettutor/features/video_call/video_call_screen.dart';

void main() {
  runApp(const LetTutor());
}

class LetTutor extends StatelessWidget {
  const LetTutor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LetTutor',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          hintColor: Colors.grey,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.blue[600],
            ),
            displayMedium: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.blue[600],
            ),
            displaySmall: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            bodyMedium: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ),
        home: const LoginScreen(),
        routes: {
          Routes.login: (context) => const LoginScreen(),
          Routes.register: (context) => const RegisterScreen(),
          Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
          Routes.main: (context) => const TabBarNavigator(),
          Routes.tutorDetail: (context) => const TutorDetailScreen(),
          Routes.courseDetail: (context) => const CourseDetailScreen(),
          Routes.videoCall: (context) => const VideoCallScreen(),
        });
  }
}
