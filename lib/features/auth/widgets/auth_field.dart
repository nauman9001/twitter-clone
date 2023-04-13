import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController contoller;
  final String hintText;
   const AuthField({Key? key, required this.contoller,required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:contoller ,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18.0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color:Pallete.blueColor,width: 3)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color:Pallete.greyColor,width: 3)
        ),
        
      ),
    );
  }
}
