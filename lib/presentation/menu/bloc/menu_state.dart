part of 'menu_bloc.dart';

class MenuState extends Equatable {
  final NetworkStatus status;
  final String? slugName;
  final String? appName;
  final String? appVersion;

  const MenuState({this.slugName, this.appName, this.appVersion, this.status = NetworkStatus.initial});

  MenuState copy(
      {BuildContext? context, NotificationDataModel? notificationResponse, String? slugName, NetworkStatus? status,String? appName,String? appVersion}) {
    return MenuState(
        status: status ?? this.status,
        slugName: slugName ?? this.slugName,
        appName: appName ?? this.appName,
        appVersion: appVersion ?? this.appVersion);
  }

  @override
  List<Object?> get props => [slugName, status];
}
