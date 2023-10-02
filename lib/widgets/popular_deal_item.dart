import 'dart:ffi';
import 'dart:math';

import 'package:denshihanbai/apps/const/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import '../apps/themes/theme.dart';
import 'small_button.dart';

class PopularDealItem extends StatefulWidget {
  PopularDealItem({
    super.key,
    required this.Title,
    required this.price,
    this.likeCount = 0,
    this.disCount = 0,
  });
  int disCount;
  String Title;
  double price;
  int likeCount;
  void handleTapLike(isLiked) {}
  @override
  State<PopularDealItem> createState() => _PopularDealItemState();
}

class _PopularDealItemState extends State<PopularDealItem> {
  int addCount = 0;
  late int disCount;
  late String price;
  void handleAddToCart() {
    setState(() {
      addCount = 1;
    });
  }

  void handleSubTrack() {
    setState(() {
      if (addCount > 0) {
        addCount -= 1;
      }
    });
  }

  void handleAdd() {
    setState(() {
      if (addCount > 0) {
        addCount += 1;
      }
    });
  }

  @override
  void initState() {
    disCount = widget.disCount;
    price = '\$${widget.price}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLiked = false;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  LikeButton(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      size: 40,
                      // likeCount: 0,
                      likeBuilder: (bool like) {
                        return like
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              );
                      }),
                  Visibility(
                    visible: (disCount != 0),
                    child: Positioned(
                      top: 10,
                      right: -40,
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          width: screenWidth / 3,
                          color: Colors.red,
                          child: Text(
                            '$disCount% $textOFF',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.Title,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  price,
                  style: const TextStyle(color: Color(0xffC29C1D)),
                ),
                Wrap(
                  children: [
                    Text(
                      widget.likeCount.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFA902),
                    )
                  ],
                ),
              ],
            ),
          ),
          (addCount == 0)
              ? TextButton(
                  onPressed: () {
                    handleAddToCart();
                  },
                  child: Container(
                    width: double.infinity,
                    height: screenWidth / 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(75),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      textAddToCart,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                    )),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SmallButton(Title: '-', onTap: handleSubTrack),
                      Text(
                        addCount.toString(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      SmallButton(
                        Title: '+',
                        onTap: handleAdd,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
