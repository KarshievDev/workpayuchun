import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/support/view/create_support/create_support_content/create_support_content.dart';
import 'package:core/core.dart';

class CreateSupportPage extends StatelessWidget {
  const CreateSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("create_support_ticket"),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: appBarColor, fontSize: 14.r),
        ),
      ),
      body: const CreateSupportListContent(),
    );
  }
}
