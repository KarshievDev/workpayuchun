import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UploadFileEvent extends Equatable{}

class SelectFile extends UploadFileEvent{

  final BuildContext context;

  SelectFile({required this.context});

  @override
  List<Object?> get props => [];
}

class UploadFile extends UploadFileEvent{

  final File file;

  UploadFile({required this.file});

  @override
  List<Object?> get props => [file.path];
}