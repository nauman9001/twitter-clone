import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/theme/pallete.dart';

import 'assetsConstants.dart';

class UiConstants{
  static AppBar appBar(){
    return AppBar(
      centerTitle: true,
      title:SvgPicture.asset(
        AssetsConstants.twitterLogo,
      color:Pallete.blueColor ,
        height: 30,
    ),);
  }
}