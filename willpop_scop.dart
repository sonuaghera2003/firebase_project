import 'package:flutter/material.dart';

class WillScopDemo extends StatefulWidget {
  const WillScopDemo({super.key});

  @override
  State<WillScopDemo> createState() => _WillScopDemoState();
}

class _WillScopDemoState extends State<WillScopDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          showDialog(
              context: context,
              builder: (context) => AlertDialog(title: Text("Exit")),
              barrierDismissible: false);
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => WillPopScope(
                        onWillPop: ()async{
                          return true;
                        },
                        child: AlertDialog(title: Text("Exit"))),
                    barrierDismissible: false);
              },
              child: Text("Dailog"),
            ),
          ],
        ),
      ),
    );
  }
}
