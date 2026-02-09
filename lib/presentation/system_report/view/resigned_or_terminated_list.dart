import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../document/view/content/custom_app_bar.dart';

class ResignedOrTerminatedList extends StatelessWidget {
  const ResignedOrTerminatedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorGray,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              const CustomAppBar(title: "Resigned Or Terminated List",),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              child: ClipOval(
                                child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFwlTyKJZQTzAUHm3ClY49pHSKyWFu1a6l7A&s',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kristin Watson",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                Text("ID: #5032",style: TextStyle(color: colorPrimary,fontWeight: FontWeight.normal,fontSize: 12),),
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Text("There are many variations of passages of Lorem Ipsum available, but the  majority have suffered alterat some..",style: TextStyle(color: Colors.black54,fontSize: 12),),
                        const SizedBox(height: 5,),
                        const Text("Due Date: 23 May 2024",style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 5,),
                        const Row(
                          children: [
                            Text("Department: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("Account",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.normal),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1),borderRadius: BorderRadius.circular(30)),
                            child: const Text("Resigned",style: TextStyle(color: Colors.green,fontSize: 10,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  );
                },

              )
            ],
          ),
        ),
      ),
    );
  }
}
