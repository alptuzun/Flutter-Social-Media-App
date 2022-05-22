import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketCard extends StatelessWidget {
  final Post post;

  final VoidCallback addToBasket;

  const MarketCard(
      {Key? key,
        required this.post,
        required this.addToBasket,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  post.user.fullName,
                  style: Styles.userNameTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 0.75,
                ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 100),
                ),
                Text(
                  "@${post.user.username}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                Text(
                  post.date,
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
              child: Image(
                image: AssetImage(post.imageName.toString()),
                alignment: Alignment.center,
                isAntiAlias: true,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            if (post.caption != null)
              Text(
                post.caption ?? "",
                style: Styles.appMainTextStyle,
              ),
            if (post.caption != null)
              SizedBox(
                height: screenHeight(context, dividedBy: 100),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Icon(Icons.money,
                  color: Colors.green,
                  size: screenWidth(context, dividedBy: 16,)
                  //constraints: const BoxConstraints(),
                  //padding: EdgeInsets.zero,
                ),
                const Spacer(
                  flex:2,
                ),
                if (post.price!= null)
                  Text(post.price ?? "",
                    style: Styles.appMainTextStyle,),

                const Spacer(
                  flex: 52,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.shopping_cart_rounded),
                  onPressed: addToBasket,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 14,
                  color: Colors.blue,
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }}