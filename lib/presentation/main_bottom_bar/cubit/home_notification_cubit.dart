import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_notification_state.dart';
part 'home_notification_cubit.freezed.dart';

class HomeNotificationCubit extends Cubit<HomeNotificationState> {
  HomeNotificationCubit() : super(HomeNotificationState.initial());
}
