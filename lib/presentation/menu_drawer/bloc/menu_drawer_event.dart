part of 'menu_drawer_bloc.dart';

abstract class MenuDrawerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuDrawerLoadData extends MenuDrawerEvent {
  final BuildContext context;
  final String? slug;
  final ResponseAllContents? responseAllContents;

  MenuDrawerLoadData({this.slug, required this.context, this.responseAllContents});

  @override
  List<Object?> get props => [slug, context, responseAllContents];
}
