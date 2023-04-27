import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/common/error_text.dart';
import 'package:twitter/common/loading_indicator.dart';
import 'package:twitter/features/auth/controller/auth_controller.dart';
import 'package:twitter/features/home/views/home_view.dart';
import 'package:twitter/theme/theme.dart';
import 'features/auth/view/signUp.dart';

void main() {
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef reff) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home:reff.watch(currentUserAccountProvider).when(
          data: (user){
            if(user!=null){
              print(user.email);
              return const HomeView();
            }
            return const SignUp();
          },
          error:(e,stackTrace)=>ErrorPage(error: e.toString()),
          loading: ()=>const  LoadingPage()
      )
    );
  }
}

