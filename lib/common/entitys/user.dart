
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

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json['code'],
        info: json["info"],
        accessToken: json["data"]!= null ? json["data"]['accessToken']: null,
        displayName: json["data"]!= null ? json["data"]["displayName"]: 'murphy',
        channels: json['data'] != null
          ? List<String>.from(json['data']['channels'])
          : [],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "channels": List<dynamic>.from(channels!.map((x) => x)),
      };
}

class UserInfo {
    String accessToken;
    String displayName;
    List<String> channels;

    UserInfo({
        required this.accessToken,
        required this.displayName,
        required this.channels,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        channels: List<String>.from(json["channels"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "channels": List<dynamic>.from(channels.map((x) => x)),
    };
}