import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RegistrationHeader extends StatelessWidget {

  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child:  InkWell(
        onTap: () {
          // provider.pickImage(context);
        },
        child: Center(
            child: Stack(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: "https://www.w3schools.com/howto/img_avatar.png",
                    placeholder: (context, url) => Center(
                      child: Image.asset("assets/images/placeholder.png"),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 0,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
