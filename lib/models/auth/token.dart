class Token {
  String? token;
  String? expires;

  Token({
    this.token,
    this.expires,
  });

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'expires': expires,
  };
}