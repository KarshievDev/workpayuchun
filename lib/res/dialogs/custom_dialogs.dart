import 'dart:io';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/login/view/login_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ComplainDialog extends StatelessWidget {
  final Function? onCameraClick;
  final Function? onGalleryClick;

  const ComplainDialog({super.key, this.onCameraClick, this.onGalleryClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "For your responsible client ask refund make proper explanation",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "There are many variations of passages of Lorem Ipsum available, but the  majority have suffered alteration in some form, by injected humour, or  randomised words which don't look even slightly believable. If you are  going to use a passage of Lorem Ipsum, you need to be sure there isn't  anything embarrassing hidden in the middle of text. All the Lorem Ipsum  generators on the Internet tend to repeat predefined chunks as  necessary, making this the first true generator on the Internet. It uses  a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem  Ipsum which looks reasonable. The generated Lorem Ipsum is therefore  always free from repetition, injected humour, or non-characteristic  words etc.",
                  style: TextStyle(color: Colors.black54, fontSize: 10),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Date: 23 May 2024",
                      style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
                    )),
                    Text(
                      "Deadline: 30 May 2024",
                      style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Creator: Dr. Jenny Wilson (Management)",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                          decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Appeal",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showRegistrationSuccessDialog(
    {required BuildContext context,
    bool isSuccess = true,
    String message = 'Account Verification',
    String body = ''}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Center(
              child: Text(
            message,
            style: const TextStyle(fontSize: 18.0),
          )),
          contentPadding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: isSuccess ? Colors.green : Colors.red,
              child: Icon(
                isSuccess ? Icons.done : Icons.close,
                size: 60.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              body,
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () => Navigator.pushAndRemoveUntil(context, LoginPage.route(), (_) => false),
                child: const Text('Back'))
          ],
        );
      });
}

void showLoginDialog(
    {required BuildContext context, bool isSuccess = true, String message = 'Account Login', String body = ''}) {
  showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Center(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0),
          )),
          contentPadding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: isSuccess ? Colors.green : Colors.red,
              child: Icon(
                isSuccess ? Icons.done : Icons.close,
                size: 60.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              body.tr(),
              textAlign: TextAlign.center,
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child:  Text('Back'.tr()))
          ],
        );
      });
}

showYearPicker(
    {required BuildContext context,
    required Function(DateTime dateTime) onDatePicked,
    DateTime? initialDate,
    required DateTime selectDate}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Select Year', style: Theme.of(context).textTheme.titleMedium),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 5),
              lastDate: DateTime.now(),
              selectedDate: selectDate,
              onChanged: onDatePicked,
            ),
          ),
        );
      });
}

showCustomDatePicker(
    {required BuildContext context, required Function(DateTime dateTime) onDatePicked, DateTime? initialDate}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: SfDateRangePicker(
                onSelectionChanged: (arg) {
                  onDatePicked(arg.value);
                  Navigator.of(context).pop();
                },
                onSubmit: (arg) {},
                maxDate: DateTime.now().add(const Duration(days: 365)),
                initialDisplayDate: initialDate ?? DateTime.now(),
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                allowViewNavigation: true,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class CustomDialogImagePicker extends StatelessWidget {
  final Function? onCameraClick;
  final Function? onGalleryClick;

  const CustomDialogImagePicker({super.key, this.onCameraClick, this.onGalleryClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        color: Colors.white,
        height: 215,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Select Image",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (onCameraClick != null) onCameraClick!();
                  },
                  child: Column(
                    children: [
                      Lottie.asset("assets/images/ic_camera.json", height: 50, width: 50),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                InkWell(
                  onTap: () {
                    if (onGalleryClick != null) onGalleryClick!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      children: [
                        Lottie.asset("assets/images/ic_gallery.json", height: 50, width: 50),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentLetterDialog extends StatelessWidget {
  final DocumentItem? documentItem;

  const AppointmentLetterDialog({super.key, required this.documentItem});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        documentItem?.docTypeName ?? '',
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black54,
                            size: 18,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    documentItem?.description ?? '',
                    maxLines: 5,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    getDDMMYYYYAsString(
                        date: documentItem?.date ?? '', inputFormat: 'yyyy-MM-dd', outputFormat: 'dd MMMM yyyy') ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Informed: ${documentItem?.documentInform?.name ?? ''}",
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    documentItem?.documentInform?.designation ?? '',
                    style: const TextStyle(color: Colors.black38, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (documentItem?.responseFile != null)
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      shareFile(fileLink: documentItem?.responseFile);
                    },
                    child: const Text(
                      "Share",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      downloadFile(fileLink: documentItem?.responseFile);
                    },
                    child: const Text(
                      "Download",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialogFaceError extends StatelessWidget {
  final Function? onYesClick;
  final Function? onNoClick;

  const CustomDialogFaceError({super.key, this.onYesClick, this.onNoClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 340,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Lottie.asset("assets/images/face_error.json", height: 200, width: 200)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Make sure the registration of your face is correct before you try again if your face does not match",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Okay",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

Future<File?> pickFile(BuildContext context) async {
  File? file;

  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialogImagePicker(
        onCameraClick: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          file = File(image!.path);
          debugPrint(image.path);
          if (!context.mounted) return;
          Navigator.of(context).pop(file);
        },
        onGalleryClick: () async {
          final ImagePicker pickerGallery = ImagePicker();
          final XFile? imageGallery =
              await pickerGallery.pickImage(source: ImageSource.gallery);
          file = File(imageGallery!.path);
          debugPrint(file?.path);
          if (!context.mounted) return;
          Navigator.of(context).pop(file);
        },
      );
    },
  );
}
