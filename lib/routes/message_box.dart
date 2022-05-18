import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/message.dart';
import 'package:cs310_group_28/ui/messagecard.dart';
import 'package:google_fonts/google_fonts.dart';

List<Message> sampleMessages = [
  Message(
    message: "I will think about it.",
    time_ago: "10m ago",
    user: User(
      username: 'klcilkr',
      fullName: 'İlker Kılıç',
      email: 'klclkr@sabanciuniv.edu',
    ),
    message_type: "Market Place",
    IsRead: true,
    incoming: true,
  ),
  Message(
    message: "Ok it is done.",
    time_ago: "12m ago",
    user: User(
      username: 'Sila',
      fullName: 'Sıla Özinan',
      email: 'silaozinan@sabanciuniv.edu',
    ),
    message_type: "Market Place",
    IsRead: false,
    incoming: true,
  ),
  Message(
    message: "Deal!, I am selling my F1 car to you.",
    time_ago: "35m ago",
    user: User(
      username: 'lewis',
      fullName: 'Lewis Hamilton',
      email: 'hamiltonlewis@sabanciuniv.edu',
    ),
    message_type: "Market Place",
    IsRead: true,
    incoming: true,
  ),
  Message(
    message: "See u",
    time_ago: "1h ago",
    user: User(
      username: 'sermetozgu',
      fullName: 'Sermet Özgü',
      email: 'sermetozgu@sabanciuniv.edu',
    ),
    message_type: "Private",
    IsRead: true,
    incoming: false,
  ),
  Message(
    message: "200\$ is ok for you?",
    time_ago: "1h ago",
    user: User(
      username: "alptuzun",
      email: "alptuzun@sabanciuniv.edu",
      fullName: "Alp Tüzün",
    ),
    message_type: "Market Place",
    incoming: true,
    IsRead: true,
  ),
  Message(
      message: "Have you cheated on your exam?",
      time_ago: "2h ago",
      user: User(
        username: 'levi',
        fullName: 'Albert Levi',
        email: 'levi@sabanciuniv.edu',
      ),
      message_type: "Private",
      incoming: true,
      IsRead: false),
  Message(
      message: "This Wednesday is ok.",
      time_ago: "2h ago",
      user: User(
        username: 'ozgun12',
        fullName: 'Ali Özgün Akyüz',
        email: 'akyuz@sabanciuniv.edu',
      ),
      message_type: "Private",
      incoming: true,
      IsRead: false),
  Message(
    message: "I'll handle it",
    time_ago: "3h ago",
    user: User(
      username: 'emre26',
      fullName: 'Emre Güneş',
      email: 'emregunes@sabanciuniv.edu',
    ),
    message_type: "Private",
    IsRead: true,
    incoming: true,
  ),
  Message(
    message: "Hii",
    time_ago: "4h ago",
    user: User(
      username: "isiktantanis",
      email: "isiktantanis@sabanciuniv.edu",
      fullName: "Işıktan Tanış",
    ),
    message_type: "Market Place",
    incoming: true,
    IsRead: false,
  ),
  Message(
      message: "OK",
      time_ago: "1d ago",
      user: User(
        username: 'eylül.simsek',
        fullName: 'Eylül Şimşek',
        email: 'eylülsimsek@sabanciuniv.edu',
      ),
      message_type: "Private",
      IsRead: true,
      incoming: false),
];

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  static const String routeName = "/notifications";

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 30,
                  ),
                  color: AppColors.titleColor,
                  onPressed: () {
                    Navigator.pop(context); // pop the context
                  }),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                "Messages",
                textAlign: TextAlign.center,
                style: Styles.appBarTitleTextStyle,
              ),
              centerTitle: true,
            ),
            backgroundColor: const Color(0xCBFFFFFF),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 26),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Form(
                        key: _formKey2,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: SizedBox(
                              width: double.infinity,
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Search',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.search),
                                ],
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: Styles.boldTitleTextStyle,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.buttonColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: sampleMessages
                        .map((message) => Messagecard(
                              message: message,
                            ))
                        .toList(),
                  ),
                ],
              ),
            )));
  }
}
