import 'package:equatable/equatable.dart';
import 'package:plugilo/domain/auth/access_token.dart';
import 'package:plugilo/domain/auth/user.dart';

class AuthState extends Equatable {
  const AuthState({
    this.isAuth = false,
    this.accessToken,
    this.user,
  });

  final bool isAuth;
  final AccessToken? accessToken;
  final User? user;

  AuthState copyWith({
    bool? isAuth,
    AccessToken? accessToken,
    User? user,
  }) {
    return AuthState(
      isAuth: isAuth ?? this.isAuth,
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isAuth,
        accessToken,
        user,
      ];

  @override
  String toString() => 'AuthState { isAuth: $isAuth, accessToken: $accessToken, user ${user?.id} ${user?.email} }';
}
