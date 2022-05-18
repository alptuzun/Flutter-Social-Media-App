import 'package:cs310_group_28/ui/styled_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledTextField extends StatelessWidget {
  final TextInputType inputType;
  final IconData icon;
  final String placeholder;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChanged;
  const StyledTextField({
    Key? key,
    this.inputType = TextInputType.name,
    required this.icon,
    required this.placeholder,
    this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledTextFieldContainer(
        child: TextFormField(
      keyboardType: inputType,
      onChanged: onChanged,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: GoogleFonts.poppins(fontSize: 14),
          icon: Icon(
            icon,
            color: const Color(0xFF012169),
          ),
          border: InputBorder.none),
      validator: validator,
    ));
  }
}
