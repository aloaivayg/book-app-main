import 'package:bloc/bloc.dart';
import 'package:book_app/src/settings/settings_controller.dart';
import 'package:book_app/src/settings/settings_service.dart';
import 'package:equatable/equatable.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  AppSettingBloc() : super(AppSettingInitial()) {
    on<AppSettingInitialEvent>(onAppSettingInitialEvent);
  }

  SettingsController settingsController = SettingsController(SettingsService());

  void onAppSettingInitialEvent(
      AppSettingInitialEvent event, Emitter<AppSettingState> emit) async {
    print("INIT");
    settingsController = event.settingsController;
    await settingsController.loadSettings();
    emit(AppSettingInitialSuccess(settingsController));
  }
}
