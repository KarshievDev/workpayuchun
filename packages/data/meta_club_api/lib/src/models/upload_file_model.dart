class FileUpload {
  final bool? result;
  final String? message;
  final String? previewUrl;
  final int? fileId;

  FileUpload({this.result, this.message, this.previewUrl, this.fileId});

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
        result: json['result'],
        message: json['message'],
        previewUrl: json['data'] != null ? json['data']['preview_url'] : null,
        fileId: json['data'] != null ? json['data']['file_id'] : null);
  }
}
