import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/upload_file/bloc/upload_file_bloc.dart';
import 'package:strawberryhrm/presentation/upload_file/bloc/upload_file_event.dart';
import 'package:strawberryhrm/presentation/upload_file/bloc/upload_file_state.dart';

class UploadDocContent extends StatelessWidget {
  final Function(FileUpload? data) onFileUpload;
  final String? initialAvatar;
  final String? buttonText;

  const UploadDocContent(
      {super.key, required this.onFileUpload, this.initialAvatar, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadFileBloc>(
      create: (context) => UploadFileBloc(
          metaClubApiClient: MetaClubApiClient(
              httpService: instance())),
      child: BlocListener<UploadFileBloc, UploadFileState>(
        listener: (context, state) {
          if (state.networkStatus == NetworkStatus.success) {
            onFileUpload(state.fileUpload);
          }
        },
        child: BlocBuilder<UploadFileBloc, UploadFileState>(
            builder: (context, state) {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: state.networkStatus != NetworkStatus.loading
                    ? CachedNetworkImage(
                        height: DeviceUtil.isTablet ? 200.h : 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: '${state.fileUpload?.previewUrl ?? initialAvatar}',
                        placeholder: (context, url) => Center(
                          child: Image.asset("assets/images/app_icon.png"),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  context
                      .read<UploadFileBloc>()
                      .add(SelectFile(context: context));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: DeviceUtil.isTablet ? 45.h : 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 0.0,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DottedBorder(
                      color: const Color(0xffC7C7C7),
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      strokeWidth: 2,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: Colors.grey,
                              size: DeviceUtil.isTablet ? 16.r : 18,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              tr(buttonText ?? "add_file"),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: DeviceUtil.isTablet ? 12.r : 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
