import 'package:cs310_group_28/visuals/app_dimensions.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';

class StyledTextFieldContainer extends StatelessWidget {
  final Widget child;
  final bool dominantColor;

  const StyledTextFieldContainer(
      {Key? key, required this.child, this.dominantColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: Dimensions.regularPadding,
        width: screenWidth(context, dividedBy: 1.1),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: Color(dominantColor ? 0xFF012169 : 0xFFabcae9),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
          child: child,
        ));
  }
}
