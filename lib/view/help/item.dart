import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class HelpItem extends StatelessWidget {
  HelpItem({Key key, this.index, this.left, this.right}) : super(key: key);
  final int index;
  final List<String> left;
  final List<String> right;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getSenderView(
          ChatBubbleClipper8(type: BubbleType.sendBubble),
          context,
        ),
        getReceiverView(
          ChatBubbleClipper8(type: BubbleType.receiverBubble),
          context,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  getSenderView(CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            left[index],
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        backGroundColor: Colors.blueGrey,
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            right[index],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
