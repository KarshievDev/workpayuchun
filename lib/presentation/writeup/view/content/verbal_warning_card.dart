import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class VerbalWarningCard extends StatelessWidget {
  final Complain complain;
  const VerbalWarningCard({super.key, required this.complain});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            complain.title ?? '',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            complain.description ?? '',
            maxLines: 5,
            style: const TextStyle(color: Colors.black54, fontSize: 11.0),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'Date: ${getDDMMYYYYAsString(date: complain.date ?? '', inputFormat: 'yyyy-MM-dd', outputFormat: 'dd MMMM yyyy')}',
            style: const TextStyle(color: Colors.red, fontSize: 11.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Creator: ${complain.creator?.name} (${complain.creator?.designation})',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 11.0),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration:
                  BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)),
              child: Text(
                complain.status ?? '',
                style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
