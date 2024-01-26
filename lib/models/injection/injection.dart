import 'package:get_it/get_it.dart';
import 'package:lettutor/models/tutor/tutor_become.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() async {
  getIt.registerSingleton<TutorBecome>(TutorBecome(price: 50000));
}
