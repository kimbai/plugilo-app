import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/common/cubit/auth_state.dart';
import 'package:plugilo/data/repo/auth_repository.dart';
import 'package:plugilo/domain/auth/access_token.dart';
import 'package:plugilo/domain/auth/user.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState()) {
    init();
  }

  final AuthRepository _authRepository;

  void init() async {
    final token = await _authRepository.getAccessToken();
    final user = await _authRepository.getLoggedUserInfo();
    _authRepository.dioUpdateAccessToken(token?.accessToken);

    emit(state.copyWith(
      accessToken: token,
      isAuth: token == null ? false : true,
      user: user,
    ));
  }

  void setAccessToken(AccessToken? token) {
    if (token == null || token.accessToken == null || token.accessToken!.isEmpty) {
      _authRepository.clearAccessToken();
      _authRepository.dioUpdateAccessToken(null);
      emit(state.copyWith(accessToken: null, isAuth: false));
    } else {
      _authRepository.saveAccessToken(token);
      _authRepository.dioUpdateAccessToken(token.accessToken);
      emit(state.copyWith(accessToken: token, isAuth: true));
    }
  }

  AccessToken? getAccessToken() {
    return state.accessToken;
  }

  void setUser(User? user) {
    if (user != null) {
      _authRepository.saveLoggedUserInfo(user);
    } else {
      _authRepository.clearLoggedUserInfo();
    }
    emit(state.copyWith(user: user));
  }

  // Future<void> getProfile() async {
  //   final result = await _authRepository.getProfile();
  //   result.fold(
  //     (error) {},
  //     (response) {
  //       emit(state.copyWith(user: response.data));
  //     },
  //   );
  // }

  // logout
  Future<void> softLogout() async {
    await _authRepository.logout();
    await _authRepository.clearAccessToken();
    emit(state.copyWith(accessToken: null, isAuth: false));
  }

  Future<void> hardLogout() async {
    if (state.accessToken != null) {
      await _authRepository.logout();
    }
    await _authRepository.clearAccessToken();
    await _authRepository.clearLoggedUserInfo();
    emit(state.copyWith(accessToken: null, isAuth: false));
  }
}
