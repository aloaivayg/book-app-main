part of 'app_setting_bloc.dart';

class AppSettingState extends Equatable {
  const AppSettingState({this.settingsController});
  final SettingsController? settingsController;
  @override
  List<Object> get props => [settingsController!];
}

class AppSettingInitial extends AppSettingState {}

class AppSettingInitialSuccess extends AppSettingState {
  const AppSettingInitialSuccess(SettingsController settingsController)
      : super(settingsController: settingsController);
}
