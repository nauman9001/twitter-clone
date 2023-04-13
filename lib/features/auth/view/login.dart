

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/constants/ui-constants.dart';
import 'package:twitter/features/auth/widgets/round-button.dart';
import 'package:twitter/theme/pallete.dart';
import '../../../common/loading_indicator.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';

class LoginView extends ConsumerStatefulWidget {
  static route()=>MaterialPageRoute(builder:(context)=>const LoginView());
  const LoginView({Key? key}) : super(key: key);
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
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
  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }
  Widget build(BuildContext context) {
    final loading= ref.watch(authControllerProvider);
    return Scaffold(
      appBar:appBar,
      body:loading?const Loader(): Center(
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
                  onTap: onLogin,
                  label: 'Done',
                  backGroundColor:Pallete.whiteColor,
                  textColor:Pallete.backgroundColor,
                ),
              ),
              const SizedBox(height: 40,),
              RichText(
                  text: TextSpan(
                      text: "Don't have an Account?",
                      style:const  TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                          text: " SignUp",
                        style: const TextStyle(fontSize: 16,color:Pallete.blueColor ),
                        recognizer: TapGestureRecognizer()..onTap=(){}
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
