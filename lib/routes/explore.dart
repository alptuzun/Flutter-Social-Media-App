import 'dart:ffi';


import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/ui/search_card.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  static const routeName = '/explore';

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool click= true;

  void showPopupMenu() {


    showMenu(
      constraints: const BoxConstraints(maxWidth:75 ,maxHeight: 150),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)

      ),
      context: context,
      //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))) ,
      position: const RelativeRect.fromLTRB(25.0, 100, 20, 0.0),  //position where you// want to show the menu on screen

      items: [
         PopupMenuItem(

           height: 2,
           padding: const EdgeInsets.all(0),
           value: 1,
            child: Column(
              children: [
                IconButton(

                    onPressed: () {nullptr;}, icon: const Icon(Icons.account_circle_outlined, color: Colors.black,size: 20, )),

                const Divider(height: 1,color: Colors.deepPurpleAccent,thickness: 2.5,),
              ],
            ) ),

         PopupMenuItem(
             height: 2,
             padding: const EdgeInsets.all(0),
           value: 2,
            child: Column(
              children: [
                IconButton(onPressed: () {nullptr;}, icon: const Icon(Icons.location_on_outlined,color: Colors.black,size: 20, )),
                Divider(height: 1,color: Colors.deepPurpleAccent,thickness: 2.5,),
              ],
            ) ),
         PopupMenuItem(
             height: 2,
             padding: const EdgeInsets.all(0),
           value: 3,
            child: Column(
              children: [
                IconButton(onPressed: () {nullptr;}, icon: const Icon(Icons.tag,color: Colors.black,size: 20, )),
                const Divider(height: 1,color: Colors.deepPurpleAccent,thickness: 2.5,indent:15 ,),
              ],
            ) ),
      ],
      elevation: 8.0,
    );

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xCBFFFFFF),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
        ],
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
                        children:  [
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
                    suffixIcon:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,20),
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
                                child:
                                Icon((click==false)? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,
                                    size:50,
                                    color: Colors.black ),
                              )
                          ),
                        ),*/
                        Padding(

                           padding: const EdgeInsets.fromLTRB(0,0,0,20),

                           child:
                           PopupMenuButton(

                             onSelected:  (int a) {click = false;},
                             onCanceled: () {click = true;},
                             icon: Padding(
                               padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                               child:
                               Icon((click==false)? Icons.arrow_drop_up_outlined : Icons.arrow_drop_up_outlined,
                                   size:50,
                                   color: Colors.black ),
                             ),
                             shape:RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(20)

                             ) ,
                             position: PopupMenuPosition.under,
                             constraints: const BoxConstraints(maxWidth:75 ,maxHeight: 500),
                             itemBuilder: (BuildContext context) =>[
                               PopupMenuItem(

                                   height: 2,
                                   padding: const EdgeInsets.all(0),
                                   value: 1,
                                   child: Column(
                                     children: [
                                       IconButton(

                                           onPressed: () {nullptr;}, icon: const Icon(Icons.account_circle_outlined, color: Colors.black,size: 20,),constraints: const BoxConstraints(maxHeight: 30),
                                       ),

                                       const Divider(color: Colors.deepPurpleAccent,thickness: 1,indent:10,endIndent: 10,),



                                     ],
                                   ) ),
                               PopupMenuItem(
                                   height: 2,
                                   padding: const EdgeInsets.all(0),
                                   value: 2,
                                   child: Column(
                                     children: [
                                       IconButton(


                                         onPressed: () {nullptr;}, icon: const Icon(Icons.location_on_outlined,color: Colors.black,size: 20, ),
                                         constraints: const BoxConstraints(maxHeight: 30),),
                                       const Divider(color: Colors.deepPurpleAccent,thickness: 1,indent:10,endIndent: 10,),

                                     ],
                                   ) ),
                               PopupMenuItem(
                                   height: 2,
                                   padding: const EdgeInsets.all(0),
                                   value: 3,
                                   child: Column(
                                     children: [
                                       IconButton(onPressed: () {nullptr;}, icon: const Icon(Icons.tag,color: Colors.black,size: 20, ),constraints: const BoxConstraints(maxHeight: 30),),
                                       const Divider(color: Colors.deepPurpleAccent,thickness: 1,indent:10,endIndent: 10,),

                                     ],
                                   )
                               ),



                             ],
                           ),
                        ),
                        IconButton(

                          icon: const Icon(Icons.search_rounded, size: 30, color: Colors.black),
                          onPressed: () {null;},
                        )

                      ],
                      //child: Icon(Icons.search_rounded, size: 30, color: Colors.black)
                    ),


                  ),


                   //Icon(Icons.search_rounded, size: 30),
                )
              ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: samplePosts
                    .map((post) => SearchCard(
                      post: post,
                    ))
                        .toList(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
