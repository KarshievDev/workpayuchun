import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
        return SafeArea(
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Lottie.asset('assets/images/language_lottie.json',
                        height: 100, width: 100),
                    const SizedBox(
                      height: 25,
                    ),
                     Text('choose_your_preferred_language',
                            style: TextStyle(
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54))
                        .tr(),
                    const SizedBox(
                      height: 5,
                    ),
                     Text(
                      "please_select_your_language",
                      style: TextStyle(fontSize: 14.r, color: Colors.grey),
                    ).tr(),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: languages.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<LanguageBloc>()
                                  .add(SelectLanguage(context, index));
                            },
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    height: 30.r,
                                    width: 30.r,
                                    fit: BoxFit.cover,
                                    imageUrl: "${languages[index]['image']}",
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                          "assets/images/placeholder_image.png"),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                 SizedBox(
                                  width: 16.w,
                                ),
                                Text(
                                  languages[index]['name'] ?? "",
                                  style:  TextStyle(
                                      fontSize: 12.r,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                FutureBuilder(
                                    future: SharedUtil.getSelectLanguage(
                                        keySelectLanguage),
                                    builder: (context, snapShot) {
                                      return SizedBox(
                                        height: snapShot.data == index ? 30 : 0,
                                        width: snapShot.data == index ? 30 : 0,
                                        child: Icon(
                                          Icons.check,
                                          size: snapShot.data == index ? 24 : 0,
                                          color: Colors.blue.withValues(alpha:
                                              snapShot.data == index
                                                  ? 0.85
                                                  : 0),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
