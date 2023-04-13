import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/common/loading_indicator.dart';
import 'package:twitter/features/auth/view/login.dart';

import '../../../constants/ui-constants.dart';
import '../../../theme/pallete.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';
import '../widgets/round-button.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}
class _SignUpState extends ConsumerState<SignUp> {
  final appBar=UiConstants.appBar();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }
  @override
  Widget build(BuildContext context) {
    final loading= ref.watch(authControllerProvider);
    return Scaffold(
      appBar:appBar,
      body: loading?Loader():Center(
        child: SingleChildScrollView(
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AuthField( contoller: emailController, hintText: 'Email',),
              const SizedBox(height: 25,),
              AuthField( contoller: passwordController, hintText: 'Password',),
              const SizedBox(height: 40,),
              Align(
                alignment: Alignment.topRight,
                child: RoundedButton(
                  label: 'Done',
                  onTap: onSignUp,
                  backGroundColor:Pallete.whiteColor,
                  textColor:Pallete.backgroundColor,
                ),
              ),
              const SizedBox(height: 40,),
              RichText(
                  text: TextSpan(
                      text: "Already have an Account?",
                      style:const  TextStyle(fontSize: 16),
                      children: [
                        TextSpan(
                            text: " Login",
                            style: const TextStyle(fontSize: 16,color:Pallete.blueColor ),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Navigator.push(context, LoginView.route());
                            }
                        ),

                      ]
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
