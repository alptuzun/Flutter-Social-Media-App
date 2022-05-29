import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/messages_screen.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

List<Post> samplePosts = [
  Post(
    user: MyUser(
      username: "alptuzun",
      email: "alptuzun@sabanciuniv.edu",
      fullName: "Alp Tüzün",
    ),
    caption: "Very Beautiful day in San Francisco",
    date: "21 June 2021",
    // likes: 505,
    // comments: 15,
    location: "Golden Gate Bridge",
    imageName: 'assets/images/goldengate.jpg',
  ),
  Post(
    user: MyUser(
      username: "isiktantanis",
      email: "isiktantanis@sabanciuniv.edu",
      fullName: "Işıktan Tanış",
    ),
    date: "8 November 2021",
    // likes: 488,
    // comments: 27,
    imageName: 'assets/images/andriod.jpg',
  ),
  Post(
    user: MyUser(
      username: "elonmusk",
      email: "elonmusk@sabanciuniv.edu",
      fullName: "Elon Musk",
    ),
    caption: "With my new Whip",
    date: "27 May 2021",
    // likes: 1070897,
    //
    // comments: 7787,
    location: "Tesla Inc. HQ",
    imageName: 'assets/images/eloncar.jpg',
  ),
  Post(
    user: MyUser(
      username: "yasinalbayrak",
      email: "yasinalbayrak@sabanciuniv.edu",
      fullName: "Yasin Albayrak",
    ),
    caption: "Live Like A Champion",
    date: "16 May 2021",
    // likes: 247,
    //
    // comments: 12,
    imageName: "assets/images/muhammed_ali.jpg",
  )
];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = "/home_view";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  void addComment(Post post) {
    setState(() {
      // post.comments++;
    });
  }

  void addLikes(Post post) {
    setState(() {
      // post.likes++;
    });
  }

  void addDislikes(Post post) {
    setState(() {
      // post.likes--;
    });
  }

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
      if (_image != null) {
        samplePosts.insert(0,Post(user: MyUser(username: "Jeff",
          fullName: "Jeffrey Bezos",
          email: "jeff.bezos@amazon.com",
        ),
          date: "30 May 2022",
          imageName: "jeff",
          image: _image,
        ));
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      if (kDebugMode) {
        print("Upload complete");
      }
      setState(() {
        _image = null;
      });
    } on FirebaseException catch(e) {
      if (kDebugMode) {
        print('ERROR: ${e.code} - ${e.message}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
          splashRadius: 27,
          icon: const Icon(Icons.notifications_none_rounded),
          color: AppColors.titleColor,
          iconSize: 40,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Notifications()));
          },
        ),
        title: Text(
          "Feed",
          style: Styles.appBarTitleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            splashRadius: 27,
            icon: const Icon(Icons.forum_outlined),
            color: AppColors.titleColor,
            iconSize: 40,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MessageBox()));
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xCBFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: samplePosts
              .map((post) => PostCard(
                    comment: () {
                      addComment(post);
                    },
                    likes: () {
                      addLikes(post);
                    },
                    dislikes: () {
                      addDislikes(post);
                    },
                    post: post,
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: pickImage,
          child: const Icon(Icons.add_photo_alternate_outlined,
          size: 30,),
        ),
      ),
    );
  }
}
