import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const StyledButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: (screenWidth(context) / 100) * 48,
      height: (screenHeight(context) / 100) * 5.5,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 0),
            colors: [Colors.lightBlue, Colors.lightBlueAccent]),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
