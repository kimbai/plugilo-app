import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial()) {
    Future.delayed(const Duration(seconds: 2), () {
      emit(SplashState.loaded());
    });
  }
}
