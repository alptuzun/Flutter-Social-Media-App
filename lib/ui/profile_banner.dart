import 'package:cs310_group_28/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  User user;
  ProfileBanner({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 155,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(user.profilePicture),
                        radius: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(user.fullName,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        infoColumn(user.getNumPosts(), "Posts"),
                        infoColumn(user.getNumFollowers(), "Followers"),
                        infoColumn(user.getNumFollowing(), "Following"),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
                      onPressed: () {},
                      icon: const Icon(Icons.forum),
                      splashRadius: 31,
                      iconSize: 35,
                      color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.storefront),
                      splashRadius: 31,
                      iconSize: 35,
                      color: Colors.grey),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
