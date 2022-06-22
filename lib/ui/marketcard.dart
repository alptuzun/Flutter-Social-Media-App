import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';

class MarketCard extends StatelessWidget {
  final Post post;

  final VoidCallback addToBasket;

  const MarketCard({
    Key? key,
    required this.post,
    required this.addToBasket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
    );
  }
}
