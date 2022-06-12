import 'package:cs310_group_28/functions/explore_tiles.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cs310_group_28/functions/custome_explorebar.dart';

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


