import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  static route()=>MaterialPageRoute(builder:(context)=>const HomeView());
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
