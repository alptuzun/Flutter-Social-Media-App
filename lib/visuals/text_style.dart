import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static final userNameTextStyle = GoogleFonts.poppins(
    color: AppColors.mainTextColor,
    fontSize: 20.0,
    letterSpacing: -0.7,
    fontWeight: FontWeight.w600,
  );

  static final appMainTextStyle = GoogleFonts.poppins(
    color: AppColors.mainTextColor,
    fontSize: 14.0,
    letterSpacing: -0.7,
  );

  static final appButtonTextStyle = GoogleFonts.poppins(
    color: AppColors.buttonColor,
    fontSize: 20.0,
    letterSpacing: -0.5,
  );

  static final appBarTitleTextStyle = GoogleFonts.poppins(
    color: AppColors.titleColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.7,
  );

  static final darkMainText = GoogleFonts.poppins(
    color: AppColors.darkModeMainTextColor,
    fontSize: 20.0,
    letterSpacing: -0.7,
  );

  static final appGreyText = GoogleFonts.poppins(
    color: AppColors.paleButtonColor,
    fontSize: 14.0,
    letterSpacing: -0.7,
  );

  static final boldTitleTextStyle = GoogleFonts.poppins(
    color: AppColors.mainTextColor,
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.7,
  );
}
