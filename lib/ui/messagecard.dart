

import 'package:cs310_group_28/models/message.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';


class Messagecard extends StatelessWidget {
  const Messagecard({Key? key, required this.message}) : super(key: key);

  final Message message;



  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 0.5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3,20,5,20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.center,

          children:  [
            const Icon(Icons.account_circle,size: 40,),
            const SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    message.user.fullName,
                    style: Styles.userNameTextStyle,
                    textAlign: TextAlign.start,
                    textScaleFactor: 0.75,
                ),
                const SizedBox(width: 5,),
                //if (message.message.length > 29)


                Text(

                  message.message +'·' + message.time_ago,
                  style: const TextStyle(
                    fontSize: 13,

                  ),

                  //textAlign: TextAlign.,


                )

              ],
            ),



            const Spacer(),
            if (message.IsRead != true )
              const Icon(Icons.circle, size: 8,color: Colors.blue,),
            if (message.IsRead != true)
              const SizedBox(width: 12,),


            if(message.message_type != "Private")
              const Icon(Icons.storefront,size: 26,),

            if(message.message_type == "Private")
              const Icon(Icons.send_sharp,size: 26,),


            const SizedBox(width: 25,),

          ]




        ),

      ),



    );
  }
}
