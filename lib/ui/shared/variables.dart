import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
final client = SupabaseClient('https://atjikuixrjhpeggdhbnm.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMzkwNTM1NywiZXhwIjoxOTQ5NDgxMzU3fQ.ma2rjfQFG-0_DpNNj75MHkKqBwDg3-0VofTi713Uj6I');

var primaryColor = Color(0xff16103D);
//var primaryColor = Color(0xff2962FF);
var secondaryColor = Color(0xff2962FF);
//var secondaryColor = Color(0xffFEC65A);
var headerColor = Color(0xff1B1B1B);
var linesColor = Color(0xff262626);
var contentColor = Color(0xffBEBEBE);
var textFieldColor = Color(0xffA3A2A2);
var inactiveMenuColor = Color(0xff9C9C9C);
var artboardColor = Color(0xff151515);
var cardBGColor = Color(0xff2D2D2D);
var secondaryDarkLineColor = Color(0xff705728);
var colorBlack = Colors.black;
var colorRed = Colors.red;
var colorWhite = Colors.white;
var colorGrey = Color(0xffC4C4C4);
var colorStarRed = Color(0xffFF0000);

Color darkPrimaryColor = Color(0xFF1B5E20);
Color bottomBarGreyColor = Color(0xFF999999);
Color lightGreyColor = Color(0xFFCFCFCF);
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color greyTextColor = Color(0xFF7F7F7F);
Color lightGreyTextFieldBGColor = Color(0xFFEFEFEF);
Color lightlGreen  = Color(0xffFAFAFA);
Color lightDGreen  = Color(0xFF84CCB1);



double fixPadding = 10.0;

SizedBox heightSpace = SizedBox(height: 10.0);

SizedBox widthSpace = SizedBox(width: 10.0);

TextStyle appBarTextStyle = TextStyle(
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

TextStyle whiteSmallTextStyle = TextStyle(
  fontSize: 12.0,
  color: whiteColor,
);

TextStyle white42SemiBoldTextStyle = TextStyle(
  fontSize: 42.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

TextStyle white16RegularTextStyle = TextStyle(
  fontSize: 16.0,
  color: whiteColor,
);

TextStyle white14MediumTextStyle = TextStyle(
  fontSize: 14.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

TextStyle white18SemiBoldTextStyle = TextStyle(
  fontSize: 18.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

TextStyle white20SemiBoldTextStyle = TextStyle(
  fontSize: 20.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

TextStyle white16MediumTextStyle = TextStyle(
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

TextStyle white12SemiBoldTextStyle = TextStyle(
  fontSize: 12.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

TextStyle black12RegularTextStyle = TextStyle(
  fontSize: 12.0,
  color: blackColor,
);

TextStyle black14RegularTextStyle = TextStyle(
  fontSize: 14.0,
  color: blackColor,
);

TextStyle black16RegularTextStyle = TextStyle(
  fontSize: 16.0,
  color: blackColor,
);

TextStyle black16MediumTextStyle = TextStyle(
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

TextStyle black14MediumTextStyle = TextStyle(
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

TextStyle black26MediumTextStyle = TextStyle(
  fontSize: 26.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

TextStyle black18MediumTextStyle = TextStyle(
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

TextStyle black14SemiBoldTextStyle = TextStyle(
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

TextStyle black16SemiBoldTextStyle = TextStyle(
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

TextStyle grey14MediumTextStyle = TextStyle(
  fontSize: 14.0,
  color: greyTextColor,
  fontWeight: FontWeight.w500,
);

TextStyle grey20MediumTextStyle = TextStyle(
  fontSize: 20.0,
  color: greyTextColor,
  fontWeight: FontWeight.w500,
);

TextStyle grey12RegularTextStyle = TextStyle(
  fontSize: 12.0,
  color: greyTextColor,
);

TextStyle grey14RegularTextStyle = TextStyle(
  fontSize: 14.0,
  color: greyTextColor,
);

TextStyle red12RegularTextStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.red,
);

TextStyle red14RegularTextStyle = TextStyle(
  fontSize: 14.0,
  color: Colors.red,
);

TextStyle red16MediumTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.red,
  fontWeight: FontWeight.w500,
);

TextStyle green12RegularTextStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.green,
);

TextStyle green14RegularTextStyle = TextStyle(
  fontSize: 14.0,
  color: Colors.green,
);

TextStyle primaryColor16MediumTextStyle = TextStyle(
  fontSize: 16.0,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

var shadowStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: colorWhite,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0, // soften the shadow
      spreadRadius: 1.0, //extend the shadow
      offset: Offset(
        0.0, // Move to right 10  horizontally
        0.0, // Move to bottom 10 Vertically
      ),
    )
  ],
);