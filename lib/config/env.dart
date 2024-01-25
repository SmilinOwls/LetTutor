import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin IAppEnv {
  String? baseUrl;
}

class AppEnv implements IAppEnv {
  @override
  String? baseUrl = dotenv.env['BASE_URL'];
}

final appEnv = AppEnv();