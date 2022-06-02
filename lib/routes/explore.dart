import 'package:cs310_group_28/ui/search_card.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';

List<Post> sampleSearchPosts = [
  Post(
    user: User(
      username: "alptuzun",
      email: "alptuzun@sabanciuniv.edu",
      fullName: "Alp Tüzün",
    ),
    caption: "Very Beautiful day in San Francisco",
    date: "21 June 2021",
    location: "Golden Gate Bridge",
    imageName: 'assets/images/goldengate.jpg',
  ),
  Post(
    user: User(
      username: "isiktantanis",
      email: "isiktantanis@sabanciuniv.edu",
      fullName: "Işıktan Tanış",
    ),
    date: "8 November 2021",
    imageName: 'assets/images/andriod.jpg',
  ),
  Post(
    user: User(
      username: "elonmusk",
      email: "elonmusk@sabanciuniv.edu",
      fullName: "Elon Musk",
    ),
    caption: "With my new Whip",
    date: "27 May 2021",
    location: "Tesla Inc. HQ",
    imageName: 'assets/images/eloncar.jpg',
  ),
  Post(
    user: User(
      username: "yasinalbayrak",
      email: "yasinalbayrak@sabanciuniv.edu",
      fullName: "Yasin Albayrak",
    ),
    caption: "Live Like A Champion",
    date: "16 May 2021",
    imageName: "assets/images/muhammed_ali.jpg",
  ),
  Post(
      user: User(
        username: "silaozinan",
        email: "silaozinan@sabanciuniv.edu",
        fullName: "Sıla Özinan",
      ),
      caption: "fridge for sale",
      date: "21 September 2021",
      location: "Sabancı University",
      imageName: 'assets/images/fridge.jpg',
      price: "2000 TL"),
  Post(
      user: User(
        username: "aliozgunakyuz",
        email: "akyuz@sabanciuniv.edu",
        fullName: "Ali Özgün Akyüz",
      ),
      caption: "couch (only used for one semester)",
      date: "17 November 2021",
      imageName: 'assets/images/couch.jpg',
      price: "1000 TL"),
  Post(
      user: User(
        username: "sermetozgu",
        email: "sermetozgu@sabanciuniv.edu",
        fullName: "Sermet Özgü",
      ),
      caption: "I'm selling TLL101 books",
      date: "27 May 2021",
      location: "Sabancı University",
      imageName: 'assets/images/books.jpg',
      price: "150 TL"),
  Post(
      user: User(
        username: "yasinalbayrak",
        email: "yasinalbayrak@sabanciuniv.edu",
        fullName: "Yasin Albayrak",
      ),
      caption: "Anyone want to buy a bike?",
      date: "16 May 2021",
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
  bool click = false;
  bool _isOpen = false;
  String currValue = "Accounts";

  void closed() {
    setState(() {
      _isOpen = false;
    });
  }

  void showPopupMenu() {
    _isOpen = true;

    showMenu(
      semanticLabel: "popupmenu",
      constraints: const BoxConstraints(maxWidth: 75, maxHeight: 150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))) ,
      position: const RelativeRect.fromLTRB(25.0, 100, 20, 0.0),
      //position where you// want to show the menu on screen

      items: [
        PopupMenuItem(
            height: 2,
            padding: const EdgeInsets.all(0),
            value: 1,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    null;
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(maxHeight: 30),
                ),
                const Divider(
                  color: Colors.deepPurpleAccent,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
              ],
            )),
        PopupMenuItem(
            height: 2,
            padding: const EdgeInsets.all(0),
            value: 2,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    null;
                  },
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(maxHeight: 30),
                ),
                const Divider(
                  color: Colors.deepPurpleAccent,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
              ],
            )),
        PopupMenuItem(
            height: 2,
            padding: const EdgeInsets.all(0),
            value: 3,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    null;
                  },
                  icon: const Icon(
                    Icons.tag,
                    color: Colors.black,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(maxHeight: 30),
                ),
                const Divider(
                  color: Colors.deepPurpleAccent,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
              ],
            )),
      ],
      elevation: 8.0,
    ).then((_) {
      closed();
    });
  }

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
                  setState(() {
                  });
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
                  null;
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

/* backgroundColor: const Color(0xCBFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            "Search",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 17.0,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    fillColor: Colors.white70,
                    filled: true,
                    labelStyle: Styles.appMainTextStyle,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white70,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  click = !click;
                                  showPopupMenu();
                                });
                                //if(click==false){ }
                              },
                              icon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                child: Icon(
                                    (_isOpen == true)
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    size: 50,
                                    color: Colors.black),
                              )),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search_rounded,
                              size: 30, color: Colors.black),
                          onPressed: () {
                            null;
                          },
                        )
                      ],
                    ),
                  ),
                )),
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
      ), */
