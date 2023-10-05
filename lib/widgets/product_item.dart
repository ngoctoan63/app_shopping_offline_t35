import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import '../apps/themes/theme.dart';
import '../pages/product_details.dart';

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
      decoration: const BoxDecoration(),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductDetails(
                    category: 'FRUIT',
                    title: 'Thanh Long',
                    price: 25.5,
                    discount: 30,
                  )));
        },
        child: Row(
          children: [
            Container(
              width: screenWidth / 4,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
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
                    likeBuilder: (bool like) {
                      return like
                          ? Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                ),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                ),
                                color: Colors.red,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            );
                    }),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF7D8FAB),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '\$ 5  ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        )),
                                    const TextSpan(
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const AspectRatio(
                          aspectRatio: 1,
                          child: Icon(
                            Icons.shopping_cart,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
