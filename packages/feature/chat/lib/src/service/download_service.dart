import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';

downloadImage(message) async {
  int max = 101;
  int randomNumber = Random().nextInt(max);
  try {
    Uint8List imageInUnit8List = base64Decode(message);
    File file = await File('/storage/emulated/0/Download/image$randomNumber.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    Fluttertoast.showToast(msg: 'Download Complete');
  } on Exception {
    rethrow;
  }
}