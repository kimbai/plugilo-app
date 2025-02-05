import 'dart:convert';

class User {
  int? statusCode;
  String? error;
  String? message;
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? market;
  String? language;
  String? avatar;
  dynamic avatars;
  String? gender;
  String? about;
  bool? isSystemAdmin;
  List<String>? domainIds;

  User({
    this.statusCode,
    this.error,
    this.message,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.market,
    this.language,
    this.avatar,
    this.avatars,
    this.gender,
    this.about,
    this.isSystemAdmin,
    this.domainIds,
  });

  User copyWith({
    int? statusCode,
    String? error,
    String? message,
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? market,
    String? language,
    String? avatar,
    dynamic avatars,
    dynamic marketData,
    String? gender,
    String? about,
    bool? isSystemAdmin,
    List<String>? domainIds,
  }) =>
      User(
        statusCode: statusCode ?? this.statusCode,
        error: error ?? this.error,
        message: message ?? this.message,
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        market: market ?? this.market,
        language: language ?? this.language,
        avatar: avatar ?? this.avatar,
        avatars: avatars ?? this.avatars,
        gender: gender ?? this.gender,
        about: about ?? this.about,
        isSystemAdmin: isSystemAdmin ?? this.isSystemAdmin,
        domainIds: domainIds ?? this.domainIds,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        statusCode: json["statusCode"],
        error: json["error"],
        message: json["message"],
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        market: json["market"],
        language: json["language"],
        avatar: json["avatar"],
        avatars: json["avatars"],
        gender: json["gender"],
        about: json["about"],
        isSystemAdmin: json["isSystemAdmin"],
        domainIds: json["domainIds"] == null ? [] : List<String>.from(json["domainIds"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "error": error,
        "message": message,
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "market": market,
        "language": language,
        "avatar": avatar,
        "avatars": avatars?.toJson(),
        "gender": gender,
        "about": about,
        "isSystemAdmin": isSystemAdmin,
        "domainIds": domainIds == null ? [] : List<dynamic>.from(domainIds!.map((x) => x)),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final User otherUser = other as User;
    return id == otherUser.id &&
        email == otherUser.email &&
        firstName == otherUser.firstName &&
        lastName == otherUser.lastName &&
        language == otherUser.language &&
        avatar == otherUser.avatar &&
        gender == otherUser.gender &&
        about == otherUser.about &&
        isSystemAdmin == otherUser.isSystemAdmin;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ firstName.hashCode ^ lastName.hashCode ^ language.hashCode ^ avatar.hashCode ^ gender.hashCode ^ about.hashCode ^ isSystemAdmin.hashCode;
}
