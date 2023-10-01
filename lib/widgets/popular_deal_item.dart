import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import '../apps/themes/theme.dart';

class PopularDealItem extends StatefulWidget {
  const PopularDealItem({
    super.key,
  });

  void handleTapLike(isLiked) {}
  @override
  State<PopularDealItem> createState() => _PopularDealItemState();
}

class _PopularDealItemState extends State<PopularDealItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLiked = false;
    return Container(
      width: screenHeight / 3,
      // margin: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(20),
        ),
        clipBehavior: ClipContext,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border:
                    Border.all(color: Colors.grey.withOpacity(0.4), width: 0),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: LikeButton(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  size: 30,
                  likeCount: 0,
                  likeBuilder: (bool like) {
                    return like
                        ? SvgPicture.asset('assets/icons/favorite.svg')
                        : SvgPicture.asset('assets/icons/favorite_0.svg');
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
