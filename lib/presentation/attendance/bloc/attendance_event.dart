import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

abstract class AttendanceEvent extends Equatable{

}

class OnLocationRefreshEvent extends AttendanceEvent{
  @override
  List<Object?> get props => [];
}

class OnLocationInitEvent extends AttendanceEvent{
  final DashboardModel? dashboardModel;

  OnLocationInitEvent({this.dashboardModel});

  @override
  List<Object?> get props => [];
}

class OnLocationUpdated extends AttendanceEvent{
  final String place;

  OnLocationUpdated({required this.place});

  @override
  List<Object?> get props => [place];
}

class ReasonEvent extends AttendanceEvent{
  final String reasonData;

  ReasonEvent({required this.reasonData});

  @override
  List<Object?> get props => [reasonData];
}

class OnRemoteModeChanged extends AttendanceEvent{
  final int mode;

  OnRemoteModeChanged({required this.mode});

  @override
  List<Object?> get props => [mode];
}

class OnRemarkEvent extends AttendanceEvent {
  final StoreRemarksBody body;
  final BuildContext context;

  OnRemarkEvent({required this.body, required this.context});

  @override
  List<Object> get props => [body];
}

class OnAttendance extends AttendanceEvent{

  OnAttendance();

  @override
  List<Object?> get props => [];
}

class OnOfflineAttendance extends AttendanceEvent{

  OnOfflineAttendance();

  @override
  List<Object?> get props => [];
}