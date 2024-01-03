import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:photo_view/photo_view.dart';

class ChatScreen extends StatefulWidget {
  final String? senderId;
  final String receiverId;

  final String? name;

  const ChatScreen({
    Key? key,
    required this.receiverId,
    this.senderId,
    this.name,
  }) : super(key: key);

  @override
  State createState() => ChatScreenState(peerId: receiverId);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({
    Key? key,
    required this.peerId,
  });

  String peerId;

  String? id;

  List<QueryDocumentSnapshot> listMessage = List.from([]);
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    id = widget.senderId;
    // id = prefs?.getString('id') ?? '';
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    // FirebaseFirestore.instance.collection(FirebaseString.userCollection).doc(id).update({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile!);

    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Error --- ${e.message}');
    }
  }

  void onSendMessage(String content, int type) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      // CallController().notification(
      //     firebaseToken:
      //         "duhjpSgoSj-r0zeOx1odcY:APA91bHL2H2ym7L8neto3Oyr7bGMOFf5uJrOiIuQsOoHJSosF_bmAI594RVbzZ1S3CttSYzaKixOhToqLnjUXDk6LYUu7jqLOeZAr4qeXS8CJSoYgyAEk3zgulzlIJ7OQKJe7ltu7Obe");
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection("Messages")
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      // await PushNotificationRepository.pushNotification(context: context, messages: content,userID: widget.userId,peerId: widget.peerId);
      listScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      //tost
      // Get.snackbar('Warning', "Nothing to send");
    }
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      if (document.get('idFrom') == id) {
        // Right (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                document.get('type') == 0
                    // Text
                    ? RightChat(
                        message: document.get('content'),
                        profile: "",
                        time: "",
                      )
                    : document.get('type') == 1
                        // Image
                        ? Container(
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 5 : 10,
                                right: 10),
                            child: OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => PhotoView(
                                    imageProvider: NetworkImage(
                                        "${document.get('content')}"),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(0))),
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  document.get("content"),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      width: 200.0,
                                      height: 200.0,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.grey,
                                          value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null &&
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, object, stackTrace) {
                                    return Material(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.asset(
                                        'images/img_not_available.jpeg',
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        // Sticker
                        : const SizedBox(),
              ],
            ),
            // Time
            isLastMessageLeft(index)
                ? Container(
                    margin: EdgeInsets.only(left: 10, bottom: 16, right: 10),
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(
                            document.get('timestamp'),
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                : Container()
          ],
        );
      } else {
        // Left (peer message)
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? document.get('type') == 0
                          ? LeftChat(
                              message: document.get('content'),
                            )
                          : document.get('type') == 1
                              ? Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => PhotoView(
                                          imageProvider: NetworkImage(
                                              "${document.get('content')}"),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(0))),
                                    child: Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.network(
                                        document.get('content'),
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            width: 200.0,
                                            height: 200.0,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.grey,
                                                value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null &&
                                                        loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, object, stackTrace) =>
                                                Material(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.asset(
                                            'images/img_not_available.jpeg',
                                            width: 200.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox()
                      : Container(),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 10, bottom: 16, top: 5, right: 10),
                      child: Text(
                        DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(
                              document.get('timestamp'),
                            ),
                          ),
                        ),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    )
                  : Container()
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage[index - 1].get('idFrom') == id) ||
        index == 0) {
      return true;
    } else {
      return true;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage[index - 1].get('idFrom') != id) ||
        index == 0) {
      return true;
    } else {
      return true;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 70,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            widget.name!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),
                // Sticker
                /*isShowSticker ? buildSticker() : Container(),*/
                // Input content
                buildInput(),
              ],
            ),

            // Loading
            buildLoading()
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.grey))
          : Container(),
    );
  }

  Widget buildInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: TextField(
              controller: textEditingController,
              onSubmitted: (v) {
                onSendMessage(textEditingController.text, 0);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Write your message",
                prefixIcon: InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: const Icon(Icons.attach_file),
                ),
              ),
            ),
          ),
        ),
        /*IconButton(
          onPressed:  () {
            onSendMessage(textEditingController.text, 0);
          },
          icon: Icon(
            Icons.send,
          ),
        ),*/
        Container(
          margin: const EdgeInsets.only(right: 16, bottom: 16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: InkWell(
            onTap: () {
              onSendMessage(textEditingController.text, 0);
            },
            child: const Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Messages")
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(_limit)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage.addAll(snapshot.data!.docs);
                  return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data?.docs[index]),
                    itemCount: snapshot.data?.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  );
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
    );
  }
}

class LeftChat extends StatelessWidget {
  final String? message;

  const LeftChat({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text("$message"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RightChat extends StatelessWidget {
  final String? message;
  final String? time;
  final String? profile;

  const RightChat({super.key, this.message, this.profile, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                boxShadow: kElevationToShadow[3]),
            child: Text(
              "$message",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
