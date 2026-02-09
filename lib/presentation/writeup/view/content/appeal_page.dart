import 'package:flutter/material.dart';
import 'package:strawberryhrm/res/widgets/app_bar_new.dart';

class AppealPage extends StatelessWidget {
  const AppealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBarNew(title: "Appeal",),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("For your responsible cilent ask refund make proper explanaiton",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w500),),
            ),
            CheckboxListTile(
              shape: const CircleBorder(),
              title: const Text("Write explanation"),
              value: true,

              onChanged: (newValue) {  },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                minLines: 5,
                maxLines: 20,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Explanation..',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
            CheckboxListTile(
              title: const Text("Direct talk with HR"),
              value: false,
              shape: const CircleBorder(),
              onChanged: (newValue) {

              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
          ],
        ),
      ),
    );
  }
}
