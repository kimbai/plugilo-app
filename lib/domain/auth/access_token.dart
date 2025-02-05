import 'package:plugilo/core/utils/cast.dart';

class AccessToken {
  String? accessToken;
  String? refreshToken;

  AccessToken({
    accessToken,
    refreshToken,
  });

  AccessToken.fromJson(Map<String, dynamic>? json) {
    accessToken = safeCastString(json?['accessToken']);
    refreshToken = safeCastString(json?['refreshToken']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccessToken'] = accessToken;
    data['RefreshToken'] = refreshToken;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final AccessToken otherToken = other as AccessToken;
    return accessToken == otherToken.accessToken && refreshToken == otherToken.refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
