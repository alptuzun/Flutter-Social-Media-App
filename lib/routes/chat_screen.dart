import 'package:cs310_group_28/visuals/colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 10, left: 5),
              child: Row(
                children: [
                  IconButton(
                    color: AppColors.textFieldFillColor,
                    splashRadius: 25,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const CircleAvatar(
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Michael Jordan",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    color: AppColors.textFieldFillColor,
                    splashRadius: 25,
                    iconSize: 30,
                    icon: const Icon(
                      Icons.settings,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container());
  }
}
