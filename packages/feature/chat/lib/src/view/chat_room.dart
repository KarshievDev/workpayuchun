import 'package:chat/chat.dart';
import 'package:chat/src/models/friend.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'content/no_data_found_screen.dart';

class ChatRoom extends StatefulWidget {
  final String uid;
  final String cid;
  final Color primaryColor;

  const ChatRoom({super.key, required this.uid, required this.cid, required this.primaryColor});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ChatService _database = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "chat_room".tr(),
          style: const TextStyle(color: Color(0xffeeeeee)),
        ),
      ),
      body: StreamBuilder<List<Friend>>(
        stream: _database.getFriend(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const NoDataFoundWidget(
                title: "no_data_found",
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                if (widget.uid != snapshot.data?.elementAt(index).uid) {
                  String? chatUser = snapshot.data?.elementAt(index).uid;

                  String? lastMessage = snapshot.data?.elementAt(index).message;

                  ChatService().getUserData(chatUser ?? '');

                  ///after retrieve chat uid
                  ///then we can access user profile
                  return FutureBuilder<UserModel>(
                    future: _database.getUserData(chatUser!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == null) {
                          return const SizedBox.shrink();
                        }

                        final profile = snapshot.data;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConversationScreen(
                                        user: profile!,
                                        uid: widget.uid,
                                        primaryColor: widget.primaryColor,
                                        cid: widget.cid)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                                  border: Border.all(color: widget.primaryColor)),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                leading: SizedBox(
                                  height: 50.r,
                                  width: 50.r,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(profile?.avatar ?? ""),
                                  ),
                                ),
                                title: Text(
                                  '${profile?.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 14.r, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '$lastMessage',
                                  style: TextStyle(fontSize: 12.r, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: widget.primaryColor,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ));
          }
        },
      ),
    );
  }
}
