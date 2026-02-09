import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/document/view/content/custom_app_bar.dart';
import 'package:strawberryhrm/presentation/document/view/content/request_filter.dart';


class DocumentRequestWithFilter extends StatelessWidget {
  const DocumentRequestWithFilter({super.key});

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
              const CustomAppBar(title: "Request Approval",),
              const RequestFilter(),
              const SizedBox(height: 20,),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Mr. Jonh Hoo",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                const Text("12:28 PM 13 May 2024",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.normal,fontSize: 12),),
                                Text("Delivery Date : 17 May 2024",style: TextStyle(color: Colors.greenAccent.shade700,fontWeight: FontWeight.normal,fontSize: 12,),),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        const Text("Requested for a appointment letter",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        const Text("There are many variations of passages of Lorem Ipsum available, but the  majority have suffered alterat some..",style: TextStyle(color: Colors.black54,fontSize: 12),),
                        const SizedBox(height: 5,),
                        const Row(
                          children: [
                            Text("Informed: Mr. Ronaid Richard",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("(HR)",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.normal),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          color: Colors.greenAccent.shade100.withValues(alpha: 0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                                  decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1),borderRadius: BorderRadius.circular(0)),
                                  child: const Text("Provided",style: TextStyle(color: Colors.green,fontSize: 10,fontWeight: FontWeight.bold),)),
                              const Text("On 14 May 2024",style: TextStyle(fontSize: 12,color: Colors.black54),),
                              const SizedBox(width: 1,)
                            ],
                          ),
                        ),
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
