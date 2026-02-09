import 'dart:io';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

class UploadFileState extends Equatable {
  final FileUpload? fileUpload;
  final NetworkStatus networkStatus;
  final File? file;

  const UploadFileState({this.fileUpload,this.networkStatus = NetworkStatus.initial,this.file});

  UploadFileState copyWith({FileUpload? fileUpload,NetworkStatus? networkStatus}) {
    return UploadFileState(fileUpload: fileUpload ?? this.fileUpload,networkStatus: networkStatus ?? this.networkStatus);
  }

  @override
  List<Object?> get props => [fileUpload,networkStatus];
}
