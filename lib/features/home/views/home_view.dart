import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter/constants/assetsConstants.dart';
import 'package:twitter/constants/ui-constants.dart';
import 'package:twitter/features/tweets/create_tweets_view.dart';
import 'package:twitter/theme/pallete.dart';

class HomeView extends ConsumerStatefulWidget {
  static route()=>MaterialPageRoute(builder:(context)=>const HomeView());
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _page=0;
  void onPageChange(index){
    setState(() {
      _page=index;
    });
  }
  final AppBar appBar=UiConstants.appBar();
  onCreateTweet(){
    Navigator.push(context, CreateTweetScreen.route());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children:UiConstants.bottomTapBarPages
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  onCreateTweet,
      child: const Icon(Icons.add,color: Pallete.whiteColor,size: 28,),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        backgroundColor: Pallete.backgroundColor,
        onTap:onPageChange ,
        items: [
          BottomNavigationBarItem(
            icon:SvgPicture.asset(
             _page ==0?
             AssetsConstants.homeFilledIcon:
             AssetsConstants.homeOutlinedIcon,
            color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
              icon:SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor
          )),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(
              _page==2?
              AssetsConstants.notifFilledIcon:
              AssetsConstants.notifOutlinedIcon,
              color: Pallete.whiteColor,),
          ),
        ],
      ),
    );
  }
}
