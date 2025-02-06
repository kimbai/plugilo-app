import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/data/repo/auth_repository.dart';
import 'package:plugilo/generated/locale_keys.g.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInState.initial());

  final AuthRepository _authRepository;

  void signIn(String userName, String password) async {
    emit(const SignInState.loading());
    final result = await _authRepository.signIn(
      userName: userName,
      password: password,
    );
    result.fold(
      (failure) {
        emit(SignInState.error(failure.meta.message ?? LocaleKeys.commonError.tr()));
      },
      (response) {
        log("accessToken ${response.accessToken}");
        emit(SignInState.success(response.accessToken ?? ""));
      },
    );
  }
}
