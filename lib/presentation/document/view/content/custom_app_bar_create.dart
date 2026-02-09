import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomAppBarCreate extends StatelessWidget {
  final String? title;
  const CustomAppBarCreate({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorPrimary,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,color: Colors.white,)),
                const SizedBox(width: 3,),
                Text(title ?? "",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.add,color: Colors.white,),
                  Text("Create",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                  SizedBox(width: 12,)
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
