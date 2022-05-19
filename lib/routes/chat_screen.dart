import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/ui/chat_message.dart';

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
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messageList.length,
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            itemBuilder: (context, index){
              return Container(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                child: Align(
                  alignment: (messageList[index].type == "receiver" ? Alignment.topLeft : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messageList[index].type  == "receiver" ? Colors.grey.shade200 : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(messageList[index].message,
                    style: Styles.appMainTextStyle,),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 20)),
                  ),
                  SizedBox(width: screenWidth(context, dividedBy: 25)),
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: GoogleFonts.poppins(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(width: screenWidth(context, dividedBy: 60)),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
