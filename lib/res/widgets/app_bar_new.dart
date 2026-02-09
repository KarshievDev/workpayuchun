import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppBarNew extends StatelessWidget {
  final String? title;
  final double? horizontal;
  const AppBarNew({super.key,this.title,this.horizontal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal ?? 16,vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Branding.colors.primaryLight
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text(title ?? "",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
      ),
    );
  }
}
