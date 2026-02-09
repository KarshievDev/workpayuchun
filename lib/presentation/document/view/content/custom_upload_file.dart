import 'package:flutter/material.dart';

class CustomUploadFile extends StatelessWidget {
  final String title;
  const CustomUploadFile({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        const SizedBox(height: 5,),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upload File",style: TextStyle(color: Colors.black54),),
              Icon(Icons.drive_folder_upload,color: Colors.black54,)
            ],
          ),
        )
      ],
    );
  }
}
