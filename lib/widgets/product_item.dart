import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import '../apps/themes/theme.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
  });

  void handleTapLike(isLiked) {}
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLiked = false;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: screenWidth / 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              height: screenWidth / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fresh Tomatoes",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              text: const TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF7D8FAB),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\$ 5  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      )),
                                  TextSpan(
                                    text: '\$ 8.0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFBFC9DA),
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/price-tag.svg'),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text("Title",
                                  style: TextStyle(color: colorDiscount)),
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: screenWidth / 8,
                    child: SvgPicture.asset('assets/icons/cart.svg'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
