import 'package:lettutor/models/user/token.dart';

class Tokens {
  Token? access;
  Token? refresh;

  Tokens.fromJson(Map<String, dynamic> json) {
    access = Token.fromJson(json['access']);
    refresh = Token.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() => {
        'access': access?.toJson(),
        'refresh': refresh?.toJson(),
      };
}
