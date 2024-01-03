import 'package:flutter/material.dart';

import 'common_widget.dart';

class ChatDemo extends StatefulWidget {
  const ChatDemo({super.key});

  @override
  State<ChatDemo> createState() => _ChatDemoState();
}

class _ChatDemoState extends State<ChatDemo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.teal,
              title: Text(
                "Sonu Aghera",
                style: TextStyle(color: Colors.white),
              ),
              leading: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    ".idea/assets/image/IMG_20230522_222325_233.jpg"),
              ),
              actions: [
                Icon(Icons.video_call, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.call, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
            // Stack(
            //   children: [
            //     Container(
            //       child: Image.asset(".idea/assets/image/20221224_090751.jpg"),
            //     )
            //   ],
            // ),
            commonUserInputWidget(),
            commonUserInputWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.camera_alt),
                        icon: Icon(Icons.drive_folder_upload_rounded),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5, bottom: 5),
                  padding: EdgeInsets.all(10),
                  decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
                  child: Icon(
                    Icons.mic_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
