import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/widgets/general_image_previewer.dart';

class VisitPhoneUpload extends StatelessWidget {
  final int? visitID;

  const VisitPhoneUpload({super.key, this.visitID});

  @override
  Widget build(BuildContext context) {
    BodyImageUpload bodyImageUpload = BodyImageUpload();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: Text(
            tr("visit_photo_upload_(Optional)"),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.r),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 60.0,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    bodyImageUpload.id = visitID;
                    context.read<VisitBloc>().add(
                      VisitUploadPhotoEvent(context: context, bodyImageUpload: bodyImageUpload),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(2.0)),
                    child: DottedBorder(
                      color: Colors.blue,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(2),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      strokeWidth: 1,
                      child: Icon(Icons.camera_alt, color: Colors.blue, size: 24.r),
                    ),
                  ),
                ),
                BlocBuilder<VisitBloc, VisitState>(
                  builder: (context, state) {
                    if (state.isImageLoading == true) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "image_uploading".tr(),
                            style: TextStyle(
                              color: colorPrimary.withValues(alpha: 0.6),
                              fontSize: 16.r,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else if (state.isImageLoading == false) {
                      return Expanded(
                        flex: 4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.visitDetailsResponse?.data?.images?.length ?? 0,
                          itemBuilder: (BuildContext context, index) {
                            VisitDetailsImage? visitDetailsImage = state.visitDetailsResponse?.data?.images?[index];
                            return GestureDetector(
                              onTap: () {
                                if (visitDetailsImage?.fileUrl != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => GeneralImagePreviewScreen(imageUrl: visitDetailsImage!.fileUrl!),
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      visitDetailsImage?.fileUrl ?? "https://www.w3schools.com/howto/img_avatar.png",
                                  placeholder:
                                      (context, url) =>
                                          Center(child: Image.asset("assets/images/placeholder_image.png")),
                                  errorWidget:
                                      (context, url, error) => Image.asset("assets/images/placeholder_image.png"),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state.isImageLoading == true) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(
                            "image_upload_filed".tr(),
                            style: TextStyle(
                              color: colorPrimary.withValues(alpha: 0.6),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
