import 'package:flutter/material.dart';

import 'package:core/core.dart';

class HomeItem extends StatelessWidget {

  final String icon;
  final String name;
  final VoidCallback onPressed;

  const HomeItem({super.key,required this.icon,required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon,fit: BoxFit.cover,scale: 4,),
              const SizedBox(height: 12.0),
              Text(
                name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13,color: mainColor,textBaseline: TextBaseline.ideographic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
