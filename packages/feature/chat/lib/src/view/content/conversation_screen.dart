import 'dart:convert';
import 'dart:io';
import 'package:chat/src/models/models.dart';
import 'package:chat/src/service/chat_service.dart';
import 'package:chat/src/service/image_picker_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'chat_line.dart';

class ConversationScreen extends StatefulWidget {
  final UserModel user;
  final String uid;
  final String cid;
  final Color primaryColor;

  const ConversationScreen(
      {super.key, required this.user, required this.uid, required this.cid, required this.primaryColor});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ///scroll controller
  final ScrollController listScrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  String message = '';
  XFile? imageFile;
  File? file;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatService database = ChatService();
    final chatUid = '${widget.cid}${widget.user.id}';

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('${widget.user.name}'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0.r),
                  child: widget.user.avatar == null || widget.user.avatar == ''
                      ? Image.network(
                          'https://support.hubstaff.com/wp-content/uploads/2019/08/good-pic.png',
                          width: 45.0.r,
                          height: 45.0.r,
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(widget.user.avatar?.toString() ?? ""),
                        ),
                ),
              ),
            ],
          ),
          actions: const <Widget>[],
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: StreamBuilder<List<Message>>(
              stream: database.getChatRoomMessage(widget.uid, chatUid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ///By default chat screen view
                  ///where show all messages
                  return Scaffold(
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            controller: listScrollController,
                            reverse: true,
                            itemBuilder: (_, index) {
                              return ChatLine(
                                message: snapshot.data!.elementAt(index),
                                currentUser: widget.uid,
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0.r, horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 16.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                        size: 24.r,
                                      ),
                                      onPressed: () async {
                                        imageFile = await getImage();

                                        ///read the file asynchronously as the image can be very large which may cause blocking of main thread
                                        String? base64Image = base64Encode(await imageFile!.readAsBytes());

                                        Map<String, dynamic> map = {
                                          'type': 'image',
                                          'message': base64Image,
                                          'status': 'not seen',
                                          'from': widget.uid,
                                          'timestamp': '${Timestamp.now().seconds}'
                                        };

                                        ///create chat room for current user
                                        database.createChatRoom(widget.uid, chatUid, map);

                                        ///notify message received by user
                                        database.sendNotification(
                                            receiverId: widget.user.id!, message: 'New image received');

                                        ///create chat room for chat user
                                        database.createChatRoom(chatUid, widget.uid, map);

                                        ///update friend list for current user
                                        database.createFriend(widget.uid, chatUid, 'photo');

                                        ///update friend list for chat user
                                        database.createFriend(chatUid, widget.uid, 'photo');

                                        debugPrint('current uid ${widget.uid}   chat uid : $chatUid');

                                        listScrollController.animateTo(0.0,
                                            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

                                        database.sendNotificationWithTopic(
                                            topic: 'user$chatUid',
                                            title: 'New Message',
                                            body: 'Attachment',
                                            map: widget.uid,
                                            status: 'message');
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _messageController,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  style: TextStyle(color: Colors.white, fontSize: 16.0.r),
                                  decoration: InputDecoration(
                                    hintText: 'Message...',
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 14.r),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Map<String, dynamic> map = {
                                    'type': 'message',
                                    'message': _messageController.text,
                                    'status': 'not seen',
                                    'from': widget.uid,
                                    'timestamp': '${Timestamp.now().seconds}'
                                  };

                                  ///create chat room for current user
                                  database.createChatRoom(widget.uid, chatUid, map);

                                  ///notify message received by user
                                  database.sendNotification(
                                      receiverId: widget.user.id!, message: _messageController.text,);

                                  ///create chat room for chat user
                                  database.createChatRoom(chatUid, widget.uid, map);

                                  ///update chat friend list for current user
                                  database.createFriend(widget.uid, chatUid, _messageController.text);

                                  ///update chat friend list for chat user
                                  database.createFriend(chatUid, widget.uid, _messageController.text);
                                  debugPrint('current uid ${widget.uid}   chat uid : $chatUid');
                                  listScrollController.animateTo(0.0,
                                      duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

                                  database.sendNotificationWithTopic(
                                      topic: 'user$chatUid',
                                      title: 'New Message',
                                      body: _messageController.text,
                                      map: widget.uid,
                                      status: 'message');

                                  _messageController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                      radius: 25.0.r,
                                      backgroundColor: widget.primaryColor,
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 24.r,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ColoredBox(
                    color: widget.primaryColor,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            controller: listScrollController,
                            children: const [
                              SizedBox(
                                height: 16.0,
                              ),
                              Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 16.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () async {
                                        imageFile = await getImage();
                                        //print('image file : ${imageFile.path}');
                                        ///read the file asynchronously as the image can be very large which may cause blocking of main thread
                                        String? base64Image = base64Encode(await imageFile!.readAsBytes());

                                        Map<String, dynamic> map = {
                                          'type': 'image',
                                          'message': base64Image,
                                          'status': 'not seen',
                                          'from': widget.uid,
                                          'timestamp': '${Timestamp.now().seconds}'
                                        };

                                        ///create chat room for current user
                                        database.createChatRoom(widget.uid, chatUid, map);

                                        ///create chat room for chat user
                                        database.createChatRoom(chatUid, widget.uid, map);

                                        ///notify message received by user
                                        database.sendNotification(
                                            receiverId: widget.user.id!, message: 'New image received');


                                        ///update friend list for current user
                                        database.createFriend(widget.uid, chatUid, 'photo');

                                        ///update friend list for chat user
                                        database.createFriend(chatUid, widget.uid, 'photo');
                                        if (kDebugMode) {
                                          print('current uid ${widget.uid}   chat uid : $chatUid');
                                        }
                                        listScrollController.animateTo(0.0,
                                            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

                                        database.sendNotificationWithTopic(
                                            topic: 'user$chatUid',
                                            title: 'New Message',
                                            body: 'Attachment',
                                            map: widget.uid,
                                            status: 'message');
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _messageController,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                                  decoration: const InputDecoration(
                                    hintText: 'Message...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Map<String, dynamic> map = {
                                    'type': 'message',
                                    'message': _messageController.text,
                                    'status': 'not seen',
                                    'from': widget.uid,
                                    'timestamp': '${Timestamp.now().seconds}'
                                  };

                                  debugPrint(_messageController.text);

                                  ///create chat room for current user
                                  database.createChatRoom(widget.uid, chatUid, map);

                                  ///notify message received by user
                                  database.sendNotification(
                                      receiverId: widget.user.id!, message: _messageController.text);

                                  ///create chat room for chat user
                                  database.createChatRoom(chatUid, widget.uid, map);

                                  ///update chat friend list for current user
                                  database.createFriend(widget.uid, chatUid, _messageController.text);

                                  ///update chat friend list for chat user
                                  database.createFriend(chatUid, widget.uid, _messageController.text);
                                  if (kDebugMode) {
                                    print('current uid ${widget.uid}   chat uid : $chatUid');
                                  }
                                  listScrollController.animateTo(0.0,
                                      duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

                                  database.sendNotificationWithTopic(
                                      topic: 'user$chatUid',
                                      title: 'New Message',
                                      body: _messageController.text,
                                      map: widget.uid,
                                      status: 'message');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                      radius: 25.0,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.send,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
