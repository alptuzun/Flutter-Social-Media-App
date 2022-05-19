import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/explore.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/user_profile.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({Key? key}) : super(key: key);

  static const String routeName = "/page_navigator";

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  final List<Widget> _pages = [
    const HomeView(),
    const Explore(),
    const MarketPlace(),
    const UserProfile()
  ];
  int _currIdx = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _pages[_currIdx],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, -0.5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            iconSize: 32,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currIdx,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined),
                label: "Marketplace",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: "Explore",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
