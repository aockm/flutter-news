
// 登录请求
class UserLoginRequestEntity {
  String email;
  String password;

  UserLoginRequestEntity({
    required this.email,
    required this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

// 登录返回
class UserLoginResponseEntity {
  int? code;
  String? info;
  String? accessToken;
  String? displayName;
  List<String>? channels;

  UserLoginResponseEntity({ 
    this.code,
    this.info,
    required this.accessToken,
    this.displayName,
    this.channels,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic>? json,{int code=200,String info='成功'}) =>
      UserLoginResponseEntity(
        code: code,
        info: info,
        accessToken: json?['accessToken'],
        displayName: json?["displayName"]??'murphy',
        channels: List<String>.from(json?['channels'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "channels": List<dynamic>.from(channels??[].map((x) => x)),
      };
}
