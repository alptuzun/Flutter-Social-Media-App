import 'package:cs310_group_28/routes/search.dart';
import 'package:cs310_group_28/ui/search_card.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cs310_group_28/routes/explore.dart';

class CustomExploreAppBar extends StatefulWidget {
  const CustomExploreAppBar ({Key? key}) : super(key:key);

  @override
  State<CustomExploreAppBar> createState() => _CustomExploreAppBarState();
}

class _CustomExploreAppBarState extends State<CustomExploreAppBar> {
  @override
  Widget build (BuildContext context) {
    return SliverAppBar(
        floating: true,
        backgroundColor: Colors.white,
        actions: [
          if (Explore.currValue == "Accounts")
            const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            )
          else if (Explore.currValue == "Locations")
            const Icon(
              Icons.location_on_outlined,
              color: Colors.black,
            )
          else if (Explore.currValue == "Hashtags")
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
              Explore.currValue = value.toString();
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
      );

  }
}