import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../../res/nav_utail.dart';
import '../../bloc/visit_bloc.dart';
import '../visit_details_page/visit_details_page.dart';
import 'history_status.dart';

class HistoryItem extends StatelessWidget {
  final History? myHistoryList;

  const HistoryItem({super.key, this.myHistoryList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavUtil.navigateScreen(
            context,
            BlocProvider.value(
                value: context.read<VisitBloc>(),
                child: VisitDetailsPage(
                  visitID: myHistoryList!.id!,
                )));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueAccent,
                            size: 20,
                          )),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              myHistoryList?.month ?? "",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blue),
                            ),
                            Text(
                              myHistoryList?.day ?? "",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myHistoryList?.title ?? "",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${myHistoryList?.started ?? ""} - ${myHistoryList?.reached ?? ""}",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              HistoryStatus(myHistoryList: myHistoryList,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
