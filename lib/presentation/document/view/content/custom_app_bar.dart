import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  const CustomAppBar({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorPrimary,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text(title ?? "",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
      ),
    );
  }
}
