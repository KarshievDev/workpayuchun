import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'menu_drawer_state.dart';
part 'menu_drawer_event.dart';

class MenuDrawerBloc extends Bloc<MenuDrawerEvent, MenuDrawerState> {
  final MetaClubApiClient _metaClubApiClient;

  MenuDrawerBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const MenuDrawerState(
          status: NetworkStatus.initial,
        )) {
    on<MenuDrawerLoadData>(_onMenuDrawerData);
  }

  void _onMenuDrawerData(MenuDrawerLoadData event, Emitter<MenuDrawerState> emit) async {
    emit(const MenuDrawerState(status: NetworkStatus.loading));
    final responseAllContents = await _metaClubApiClient.getPolicyData(event.slug);
    responseAllContents.fold((l){
      emit(const MenuDrawerState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, responseAllContents: r));
    });
  }
}
