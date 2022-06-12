import 'package:cs310_group_28/functions/explore_tiles.dart';
import 'package:cs310_group_28/routes/search.dart';
import 'package:cs310_group_28/ui/search_card.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../functions/custome_explorebar.dart';
import '../ui/postcard.dart';


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
  static String currValue = "Accounts";
}

class _ExploreState extends State<Explore> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child:  SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomExploreAppBar(),
            SliverStaggeredGrid.countBuilder(
              mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 3,
                staggeredTileBuilder: (int index) {
                  int moddedIndex = index % 20;
                  int cXCellcount = moddedIndex == 11 ? 2 : 1;
                  double mXCellCount = 1;
                  if (moddedIndex == 2 || moddedIndex == 11) {
                    mXCellCount = 2;
                  }
                  return StaggeredTile.count(cXCellcount, mXCellCount);
                },

                itemBuilder: (BuildContext context, int index) {
                return ExploreTiles(post: Post(postURL: 'https://picsum.photos/id/${1047 + index}/400/${index % 20 == 2 ? 805: 400}', postID: "1", userID: "2", username: "yasinalbayrak", fullName: "Yasin Albayrak", postTime: DateTime.now(), type: "image"));
                },
                itemCount: 38)
          ],
        )

      ),
    );

  }
}


