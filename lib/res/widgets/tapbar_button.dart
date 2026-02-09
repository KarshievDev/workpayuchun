import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TapBarButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const TapBarButton({
    super.key, this.title, this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(color: Branding.colors.primaryLight, borderRadius: BorderRadius.circular(6)),
        child: Center(child:  Text(overflow: TextOverflow.ellipsis, title ?? "", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}