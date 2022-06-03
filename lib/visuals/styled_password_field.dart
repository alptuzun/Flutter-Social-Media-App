import 'package:cs310_group_28/visuals/styled_text_field_container.dart';
import 'package:cs310_group_28/visuals/app_dimensions.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_dimensions.dart';
import 'screen_size.dart';

class StyledPasswordField extends StatefulWidget {
  final String? Function(String?)? validator;
  final ValueChanged<String> onChanged;

  const StyledPasswordField({
    Key? key,
    this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StyledPasswordField> createState() => _StyledPasswordFieldState();
}

class _StyledPasswordFieldState extends State<StyledPasswordField> {
  bool isVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StyledTextFieldContainer(
        child: Container(
            padding: Dimensions.regularPadding,
            width: screenWidth(context, dividedBy: 1.1),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: TextFormField(
                validator: widget.validator,
                keyboardType: TextInputType.visiblePassword,
                onChanged: widget.onChanged,
                autocorrect: false,
                obscureText: !isVisible,
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "Password",
                    hintStyle: GoogleFonts.poppins(fontSize: 14),
                    icon: const Icon(
                      Icons.password,
                      color: Color(0xFF012169),
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        icon: Icon(
                            isVisible ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF012169)),
                        onPressed: togglePasswordVisibility,
                        padding: const EdgeInsets.all(0)),
                    suffixIconConstraints: const BoxConstraints(maxHeight: 24)),
              ),
            )));
  }
}
