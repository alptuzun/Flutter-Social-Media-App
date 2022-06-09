import 'package:cs310_group_28/routes/search.dart';
import 'package:cs310_group_28/ui/search_card.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';

List<Post> sampleSearchPosts = [
  Post(
    postURL: "",
    type: "image",
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    username: "alptuzun",
    fullName: "Alp Tüzün",
    caption: "Very Beautiful day in San Francisco",
    location: "Golden Gate Bridge",
    imageName: 'assets/images/goldengate.jpg',
  ),
  Post(
    postURL: "",
    type: "image",
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    username: "isiktantanis",
    fullName: "Işıktan Tanış",
    imageName: 'assets/images/andriod.jpg',
  ),
  Post(
    postURL: "",
    type: "image",
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    username: "elonmusk",
    fullName: "Elon Musk",
    caption: "With my new Whip",
    location: "Tesla Inc. HQ",
    imageName: 'assets/images/eloncar.jpg',
  ),
  Post(
    postURL: "",
    type: "image",
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    username: "yasinalbayrak",
    fullName: "Yasin Albayrak",
    caption: "Live Like A Champion",
    imageName: "assets/images/muhammed_ali.jpg",
  ),
  Post(
      postURL: "",
      type: "image",
      postID: "1",
      postTime: DateTime.now(),
      userID: "2",
      username: "silaozinan",
      fullName: "Sıla Özinan",
      caption: "fridge for sale",
      location: "Sabancı University",
      imageName: 'assets/images/fridge.jpg',
      price: "2000 TL"),
  Post(
      postURL: "",
      type: "image",
      postID: "1",
      postTime: DateTime.now(),
      userID: "2",
      username: "aliozgunakyuz",
      fullName: "Ali Özgün Akyüz",
      caption: "couch (only used for one semester)",
      imageName: 'assets/images/couch.jpg',
      price: "1000 TL"),
  Post(
      postURL: "",
      type: "image",
      postID: "1",
      postTime: DateTime.now(),
      userID: "2",
      username: "sermetozgu",
      fullName: "Sermet Özgü",
      caption: "I'm selling TLL101 books",
      location: "Sabancı University",
      imageName: 'assets/images/books.jpg',
      price: "150 TL"),
  Post(
      postURL: "",
      type: "image",
      postID: "1",
      postTime: DateTime.now(),
      userID: "2",
      username: "yasinalbayrak",
      fullName: "Yasin Albayrak",
      caption: "Anyone want to buy a bike?",
      imageName: "assets/images/bike.jpg",
      price: "90 €")
];

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  static const routeName = '/explore';

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String currValue = "Accounts";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xCBFFFFFF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            actions: [
              if (currValue == "Accounts")
                const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                )
              else if (currValue == "Locations")
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                )
              else if (currValue == "Hashtags")
                const Icon(
                  Icons.tag,
                  color: Colors.black,
                ),
              PopupMenuButton(
                icon: const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.black,
                ),
                iconSize: 40,
                onSelected: (value) {
                  currValue = value.toString();
                  setState(() {});
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      height: screenHeight(context) / 100 * 5,
                      value: 'Accounts',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text("Accounts"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      height: screenHeight(context) / 100 * 5,
                      value: 'Locations',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text("Locations"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      height: screenHeight(context) / 100 * 5,
                      value: 'Hashtags',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.tag,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text("Hashtags"),
                        ],
                      ),
                    ),
                  ];
                },
              ),
              IconButton(
                padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
                splashRadius: 27,
                icon: const Icon(Icons.search_outlined),
                color: AppColors.titleColor,
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: sampleSearchPosts
                      .map((post) => SearchCard(
                            post: post,
                          ))
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
