import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/general_image_previewer.dart';

class BuildAttachment extends StatelessWidget {
  final LeaveDetailsData data;

  const BuildAttachment({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.imageUrl == null || data.imageUrl!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.attachment),
            title: Text(tr('attachment')),
          ),
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GeneralImagePreviewScreen(imageUrl: data.imageUrl!),
                  ),
                ),
            child: Hero(
              tag: data.imageUrl!,
              child: CachedNetworkImage(
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: data.imageUrl!,
                placeholder:
                    (context, url) => Center(
                      child: Image.asset('assets/images/placeholder_image.png'),
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
