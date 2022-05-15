import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  static const routeName = '/explore';

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xCBFFFFFF),
        body: SingleChildScrollView(
          child: Row(
          ),
        ),
      ),
    );
  }
}
