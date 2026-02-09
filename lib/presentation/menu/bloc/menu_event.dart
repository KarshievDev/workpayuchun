part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RouteSlug extends MenuEvent {
  final BuildContext context;
  final String? slugName;

  RouteSlug({
    this.slugName,
    required this.context,
  });

  @override
  List<Object?> get props => [
        slugName,
        context,
      ];
}

class OnAppServiceEvent extends MenuEvent {}
