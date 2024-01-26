import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/auth/forgot/forgot_password_screen.dart';
import 'package:lettutor/features/auth/login/login_screen.dart';
import 'package:lettutor/features/auth/register/register_screen.dart';
import 'package:lettutor/features/courses/course_detail/course_detail_screen.dart';
import 'package:lettutor/features/navigation/navigation_bar.dart';
import 'package:lettutor/features/account/user/become_tutor/become_tutor.dart';
import 'package:lettutor/features/tutor/tutor_detail/tutor_detail_screen.dart';
import 'package:lettutor/features/account/user/profile/profile_screen.dart';
import 'package:lettutor/firebase_options.dart';
import 'package:lettutor/models/injection/injection.dart';
import 'package:lettutor/providers/auth/auth_provider.dart';
import 'package:lettutor/providers/language/language_provider.dart';
import 'package:lettutor/providers/theme/theme_provider.dart';
import 'package:lettutor/services/dio_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  const enviroment =
  //       String.fromEnvironment('FLAVOR', defaultValue: 'development');
  //   await dotenv.load(fileName: 'env/.env.$enviroment');

  // load .env file
  await dotenv.load(fileName: 'env/.env');

  // initialise dio service to call API
  DioService();

  // check if user is logined
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? isLoginned = prefs.getString('access_token');

  // configure dependencies to support dependency injection
  configureDependencies();

  // initialize firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: LetTutor(isLoginned: isLoginned),
    ),
  );
}

class LetTutor extends StatelessWidget {
  const LetTutor({super.key, this.isLoginned});

  final String? isLoginned;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: SnackBarHelper.scaffoldKey,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).appTitle,
        theme: Provider.of<ThemeProvider>(context).getThemeMode(),
        debugShowCheckedModeBanner: false,
        locale:
            Locale(Provider.of<LanguageProvider>(context).getLanguage().id!),
        home:
            isLoginned == null ? const LoginScreen() : const TabBarNavigator(),
        navigatorObservers: const [
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        routes: {
          Routes.login: (context) => const LoginScreen(),
          Routes.register: (context) => const RegisterScreen(),
          Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
          Routes.main: (context) => const TabBarNavigator(),
          Routes.tutorDetail: (context) => const TutorDetailScreen(),
          Routes.tutorBecome: (context) => const BecomeTutorScreen(),
          Routes.courseDetail: (context) => const CourseDetailScreen(),
          Routes.userProfile: (context) => const ProfileScreen(),
        });
  }
}
