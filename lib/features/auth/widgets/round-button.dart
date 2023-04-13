import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backGroundColor;
  final Color textColor;

  const RoundedButton({Key? key,
    required this.onTap,
    required this.label,
     this.backGroundColor=Pallete.whiteColor,
     this.textColor= Pallete.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Chip(
        labelPadding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        label:Text(
          label,
      style: TextStyle(color: textColor,fontSize: 16),
      ),
        backgroundColor: backGroundColor,
      ),
    );
  }
}
