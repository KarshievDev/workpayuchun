import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/upload_file/bloc/bloc.dart';
import '../../../res/dialogs/custom_dialogs.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final MetaClubApiClient metaClubApiClient;

  UploadFileBloc({required this.metaClubApiClient}) : super(const UploadFileState()) {
    on<SelectFile>(_onSelectFile);
    on<UploadFile>(_onUploadFile);
  }

  _onSelectFile(SelectFile event, Emitter<UploadFileState> emit) async {
    File? file = await pickFile(event.context);
    debugPrint('file ${file?.path}');
    if (file != null) {
      add(UploadFile(file: file));
    }
  }

  _onUploadFile(UploadFile event, Emitter<UploadFileState> emit) async {
    emit(state.copyWith(networkStatus: NetworkStatus.loading));
    final fileData = await metaClubApiClient.uploadFile(file: event.file);
    fileData.fold((l) {
      emit(state.copyWith(networkStatus: NetworkStatus.failure));
    }, (r) {
      if (r?.result == true) {
        emit(state.copyWith(fileUpload: r, networkStatus: NetworkStatus.success));
      } else {
        emit(state.copyWith(networkStatus: NetworkStatus.failure));
      }
    });
  }
}
