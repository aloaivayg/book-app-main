part of 'app_setting_bloc.dart';

class AppSettingEvent extends Equatable {
  const AppSettingEvent();

  @override
  List<Object> get props => [];
}

class AppSettingInitialEvent extends AppSettingEvent {
  final SettingsController settingsController;

  const AppSettingInitialEvent({required this.settingsController});
}
