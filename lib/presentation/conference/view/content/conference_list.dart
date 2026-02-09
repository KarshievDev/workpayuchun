import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:strawberryhrm/presentation/conference/conference.dart';

class ConferenceList extends StatelessWidget {
  const ConferenceList({super.key});
  @override
  Widget build(BuildContext context) {
    final conferenceBloc = context.watch<ConferenceBloc>();
    return conferenceBloc.state.conference?.data?.isNotEmpty == true
        ? ListView.builder(
            itemCount: conferenceBloc.state.conference?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final data = conferenceBloc.state.conference?.data?[index];
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xFFE4EDFE), borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data?.timeText ?? "", style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),),
                          const SizedBox(height: 10,),
                          Text(data?.title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorPrimary),),
                          const SizedBox(height: 5),
                          Text(data?.description ?? "", style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Wrap(spacing: -15,
                                      children: List<Widget>.generate(
                                          data?.members?.length ?? 0, (index) {
                                            final item = data?.members?[index];
                                        return ClipOval(
                                          child: CachedNetworkImage(
                                            height: 35, width: 35, fit: BoxFit.cover,
                                            imageUrl: item?.avatar ?? "https://www.w3schools.com/howto/img_avatar.png",
                                            placeholder: (context, url) => Center(child: Image.asset("assets/images/placeholder_image.png"),),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ),
                              InkWell(
                                onTap: () async {
                                  switch (data?.button){
                                    case "Ended":
                                      Fluttertoast.showToast(msg: "You have finished your conference");
                                      break;
                                    case "Upcoming":
                                      Fluttertoast.showToast(msg: "You have an upcoming conference");
                                      break;
                                    case "Join" :
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoCallScreen(channelId: data?.roomId ?? '',)));
                                      break;
                                    default :
                                      Fluttertoast.showToast(msg: "Status unknown");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(16)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(data?.button ?? "", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                        const Icon(Icons.arrow_right, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            })
        : const NoDataFoundWidget();
  }
}
