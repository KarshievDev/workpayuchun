import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_bloc.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_state.dart';

class ReplyContent extends StatelessWidget {
  const ReplyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainBloc, ComplainState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(state.submitComplain == NetworkStatus.success)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Replies(${state.complainReplies.length})',
                style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            if(state.submitComplain == NetworkStatus.success)
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.complainReplies.length,
                  itemBuilder: (context, index) {
                    final reply = state.complainReplies.elementAtOrNull(index);

                    return Card.outlined(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 0.0),
                            title: Text(
                              reply?.complainCreator?.name ?? '',
                              style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                            ),
                            subtitle: Text(
                              reply?.complainCreator?.designation ?? '\n${reply?.complainCreator?.department ?? ''}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: CachedNetworkImageProvider(reply?.complainCreator?.avatar ?? ''),
                              ),
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 85.0),
                            child: Text(
                              reply?.description ?? '',
                              style: const TextStyle(color: Colors.black, fontSize: 15.0),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
