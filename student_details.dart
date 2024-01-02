import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/loading_process.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentsDetails extends StatefulWidget {
  const StudentsDetails({super.key});

  @override
  State<StudentsDetails> createState() => _StudentsDetailsState();
}

class _StudentsDetailsState extends State<StudentsDetails> {
  // ["sa","asdas","Dfd"]
  @override
  Widget build(BuildContext context) {
    print("Building StudentsDetails widget");

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Attendance').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                return ListTile(
                  onTap: () {
                    print("document ${snapshot.data!.docs[index].id}");
                    FirebaseFirestore.instance
                        .collection('Attendance')
                        .doc(snapshot.data!.docs[index].id)
                        .update({"name": "update"});
                  },
                  title: Text(data['name']),
                  subtitle: Text(data['roll_no'].toString()),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Attendance')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      }),
                );
              },
            );
            /*return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  onTap: () {
                    print("document ${document.id}");
                    FirebaseFirestore.instance.collection('Attendance').doc(document.id).update({
                      "name":"update"
                    });

                  },
                  title: Text(data['name']),
                  subtitle: Text(data['roll_no'].toString()),
                  trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
                    FirebaseFirestore.instance.collection('Attendance').doc(document.id).delete();
                  }),
                );
              }).toList(),
            )*/
            ;
          }) /*Container(
        child: Row(
          children: [
            Image.asset(".idea/assets/image/IMG_20230522_222325_233.jpg",width: 100,height: 100,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Sonu Aghera"),
                Text("Mota Varachha"),
              ],
            ),
          ],
        ),
      )*/
      ,
      floatingActionButton: FloatingActionButton(onPressed: () async {
        showLoadingProcess(context);
        final ImagePicker picker = ImagePicker();

        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

          Reference reference = FirebaseStorage.instance.ref().child(fileName);

          UploadTask uploadTask = reference.putFile(File(image.path));

          try {
            TaskSnapshot snapshot = await uploadTask;

            var imageUrl = await snapshot.ref.getDownloadURL();

            print("url :   $imageUrl");
            String id =
                FirebaseFirestore.instance.collection('Attendance').doc().id;
            print("-==-=-=- $id");
            FirebaseFirestore.instance.collection('Attendance').doc(id).set({
              "name": "photo upload New",
              "roll_no": 20,
              "image": "$imageUrl"
            }).whenComplete(() {
              hideLoadingProcess(context);
            });
          } on FirebaseException catch (e) {
            print('Error --- ${e.message}');
            hideLoadingProcess(context);
          }
        } else {
          hideLoadingProcess(context);
        }
      }),
    );
  }
}
