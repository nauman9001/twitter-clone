import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/common/error_text.dart';
import 'package:twitter/common/loading_indicator.dart';
import 'package:twitter/constants/assetsConstants.dart';
import 'package:twitter/core/enums/tweet_type_enum.dart';
import 'package:twitter/features/auth/controller/auth_controller.dart';
import 'package:twitter/features/tweets/widgets/carousel_image.dart';
import 'package:twitter/features/tweets/widgets/tweet_icon_button.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'hasgtags_text.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
      data: (user) {
        return Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                  //  backgroundImage: NetworkImage(user.profilePic),
                    radius: 25,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                      children: [
                        Container(
                          margin:const EdgeInsets.only(right: 5),
                        child: Text(
                         "@${ user.name}. ${timeago.format(tweet.tweetedAt,locale: "en_short")}",
                          style:const TextStyle(
                              color:Pallete.greyColor,
                              fontSize: 17
                          ),
                        ),
                        )
                      ],
                    ),
                       HashtagText(text: tweet.text),
                      if(tweet.tweetType==TweetType.image)
                        CarouselImage(imageLinks: tweet.imageLinks),
                      if(tweet.link.isNotEmpty) ...[
                        const SizedBox(height: 4,),
                        AnyLinkPreview(
                            displayDirection: UIDirection.uiDirectionHorizontal,
                            link: "https://${tweet.link}")
                      ],
                      Container(
                        margin:const EdgeInsets.only(top: 10.0,right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            TweetIconButton(
                                pathName: AssetsConstants.viewsIcon,
                                text: (
                                    tweet.commentIds.length +
                                        tweet.reshareCount +
                                        tweet.likes.length
                                ).toString(),
                                onTap:(){},
                            ),
                            TweetIconButton(
                              pathName: AssetsConstants.commentIcon,
                              text: tweet.commentIds.length.toString(),
                              onTap:(){},
                            ),
                            TweetIconButton(
                              pathName: AssetsConstants.retweetIcon,
                              text: tweet.reshareCount.toString(),
                              onTap:(){},
                            ),
                            TweetIconButton(
                              pathName: AssetsConstants.likeOutlinedIcon,
                              text: tweet.likes.toString(),
                              onTap:(){},
                            ),
                            IconButton(
                                onPressed: (){},
                                icon:const Icon(Icons.share_outlined,size: 25,color: Pallete.greyColor,))
                          ],
                        ),
                      ),
                     const SizedBox(height: 1.0,)
                  ],
                  ),
                )
              ],
            ),
            const Divider(color: Pallete.greyColor,)
          ],
        );
      },
      error: (error, stackTrace) => ErrorText(
        error: error.toString(),
      ),
      loading: () => const Loader(),
    );
  }
}