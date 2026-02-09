import 'package:flutter/material.dart';

class RequestFilter extends StatelessWidget {
  const RequestFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(5)),
            child: const Row(
              children: [
                Icon(Icons.search,color: Colors.black54,),
                SizedBox(width: 5,),
                Text("Search Request",style: TextStyle(color: Colors.black54),)
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Status",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose One",style: TextStyle(color: Colors.black54),),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Status",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose One",style: TextStyle(color: Colors.black54),),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
