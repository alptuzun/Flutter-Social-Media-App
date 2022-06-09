import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/routes/messages_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

Column infoColumn(int number, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(number.toString(), style: const TextStyle(fontSize: 20)),
      Text(text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
    ],
  );
}

class ProfileBanner extends StatelessWidget {

  final MyUser user;
  const ProfileBanner({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(user.profilePicture),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(),
                    infoColumn(user.posts.length, "Posts"),
                    const Spacer(),
                    infoColumn(user.followers.length, "Followers"),
                    const Spacer(),
                    infoColumn(user.following.length, "Following"),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(user.fullName,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MessageBox()));
                      },
                      icon: const Icon(Icons.forum),
                      splashRadius: 31,
                      iconSize: 35,
                      color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MarketPlace()));
                      },
                      icon: const Icon(Icons.storefront),
                      splashRadius: 31,
                      iconSize: 35,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
