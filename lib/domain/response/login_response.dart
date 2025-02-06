import 'dart:convert';

class LoginResponse {
  bool? success;
  String? accessToken;
  String? message;

  LoginResponse({
    this.success,
    this.accessToken,
    this.message,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        accessToken: json["accessToken"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "accessToken": accessToken,
        "message": message,
      };
}
