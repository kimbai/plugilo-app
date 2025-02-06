part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.error(String error) = _Error;
  const factory SignInState.success(String accessToken) = _Success;
}
