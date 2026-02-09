part of 'menu_drawer_bloc.dart';

class MenuDrawerState extends Equatable {
  final ResponseAllContents? responseAllContents;
  final NetworkStatus status;
  final String? slugName;

  const MenuDrawerState(
      {this.slugName,
      this.status = NetworkStatus.initial,
      this.responseAllContents});

  MenuDrawerState copyWith(
      {BuildContext? context,
      String? slugName,
      NetworkStatus? status,
      final ResponseAllContents? responseAllContents}) {
    return MenuDrawerState(
        status: status ?? this.status,
        slugName: slugName ?? this.slugName,
        responseAllContents: responseAllContents ?? this.responseAllContents);
  }

  @override
  List<Object?> get props => [slugName, status, responseAllContents];
}
