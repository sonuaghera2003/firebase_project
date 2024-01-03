import 'package:flutter/material.dart';

Widget commonUserInputWidget() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Hii, I Am Flutter Developer",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "A paragraph is a series of sentences that are organized and coherent, and are all related to a single topic. Almost every piece of writing you do that is longer than a few sentences should be organized into paragraphs. This is because paragraphs show a reader where the subdivisions of an essay begin and end, and thus help the reader see the organization of the essay and grasp its main points.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
