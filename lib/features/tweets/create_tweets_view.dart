import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter/common/loading_indicator.dart';
import 'package:twitter/constants/assetsConstants.dart';
import 'package:twitter/features/auth/controller/auth_controller.dart';
import 'package:twitter/features/auth/widgets/round-button.dart';
import 'package:twitter/theme/pallete.dart';

import '../../core/utils.dart';
import 'controller/tweetController.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route()=>MaterialPageRoute(builder: (context)=>const CreateTweetScreen());
  const CreateTweetScreen({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  List<File>images=[];
   TextEditingController tweetTextController=TextEditingController();
  void onPickImages()async{
    images =await pickImages();
  }
  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
        images: images,
        text:tweetTextController.text ,
        context: context,
    );
  //  Navigator.pop(context);
  }
  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final currentUser=ref.watch(currentUserDetailsProvider).value;
   final isLoading=ref.watch(tweetControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
          Navigator.pop(context);
          },
          icon:const Icon(Icons.close,size: 30,),),
        actions: [
          RoundedButton(
            onTap:
            shareTweet,
              // (){
              //  // print(currentUser?.toString());
              //   shareTweet;
              // },//
            label:"Share Tweet",
          backGroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          )
        ],
      ),
      body:
 isLoading ||
      currentUser==null?const
 Loader():
      SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                  radius: 30,
                   backgroundColor: Colors.blueAccent,
                  //backgroundImage: NetworkImage(currentUser.profilePic,scale: 2.0),
                ),
                 const SizedBox(width: 15.0,),
                  Expanded(
                    child: TextField(
                      controller: tweetTextController,
                      style: const TextStyle(fontSize: 22.0),
                      decoration: const InputDecoration(
                        hintText: "What's Happening?",
                        hintStyle: TextStyle(color:Pallete.greyColor,fontSize: 22),
                          border: InputBorder.none
                      ),
                      maxLines: null,
                    ),
                  )
              ],),
              if(images.isNotEmpty)
               CarouselSlider(
                  items: images.map((file)  {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                     // color: Colors.blueAccent,
                        child: Image.file(file,
                          //fit: BoxFit.fill,
                        ));
                  }
                  ).toList(),
                  options: CarouselOptions(
                    height: 400,
                    enableInfiniteScroll: false
                  )
              )
            ],
          )
        ),
      ),
      bottomNavigationBar: Container(
        decoration:const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3
            )
          )
        ),
        child: Row(
          children: [
            Padding(
              padding:const EdgeInsets.all(8.0).copyWith(left:15.0,right: 15.0),
              child:
                InkWell(
                    onTap: onPickImages,
                    child: SvgPicture.asset(AssetsConstants.galleryIcon))
            ),
            Padding(
                padding:const EdgeInsets.all(8.0).copyWith(left:15.0,right: 15.0),
                child:
                SvgPicture.asset(AssetsConstants.gifIcon)
            ),
            Padding(
                padding:const EdgeInsets.all(8.0).copyWith(left:15.0,right: 15.0),
                child:
                SvgPicture.asset(AssetsConstants.emojiIcon)
            ),
          ],
        ),

      ),
    );
  }
}
