import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24.0;
double defaultRadius = 17.0;

Color kPrimaryColor = const Color.fromRGBO(92, 64, 204, 1);
Color kBlackColor = const Color.fromRGBO(31, 20, 73, 1);
Color kWhiteColor = const Color.fromRGBO(255, 255, 255, 1);
Color kGreyColor = const Color.fromRGBO(150, 152, 169, 1);
Color kGreenColor = const Color.fromRGBO(14, 195, 174, 1);
Color kRedColor = const Color.fromRGBO(235, 112, 165, 1);
Color kBackgroundColor = const Color.fromRGBO(250, 250, 250, 1);
Color kInactiveColor = const Color.fromRGBO(219, 215, 236, 1);
Color kTransparantColor = Colors.transparent;
Color kUnavailableColor = const Color.fromRGBO(235, 236, 241, 1);
Color kAvailabeColor = const Color.fromRGBO(224, 217, 255, 1);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
