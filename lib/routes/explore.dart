import 'dart:ffi';

import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/ui/searchcard.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'message_box.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  static const routeName = '/explore';

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xCBFFFFFF),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            floating: true,
            actions: [
            ],
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 5),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration:  InputDecoration(

                    label: SizedBox(
                      width:double.infinity,
                      child: Row(
                        children: [

                          const SizedBox(width: 10),
                          Text(
                            "Search",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 17.0,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                           IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: MySearchDelegate(),
                              );},
                            icon:Icon(Icons.search_rounded),
                            iconSize:30,
                          ),

                          IconButton(
                            onPressed: () {
                              null;},
                            icon: const Icon(Icons.arrow_drop_down_outlined) ,
                            iconSize: 50,
                          ),
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
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: samplePosts
                    .map((post) => SearchCard(
                      post: post,
                    ))
                        .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
