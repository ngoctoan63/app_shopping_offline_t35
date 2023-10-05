import 'package:flutter/material.dart';

import '../apps/const/value.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({
    super.key,
    required this.category,
    required this.title,
    required this.price,
    this.discount = 0,
  });
  String category;
  String title;
  double price;
  double discount;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int cartCount = 1;
  late double discountPercent;
  late double price;
  late double discount;
  @override
  void initState() {
    price = widget.price;
    discount = widget.discount;
    super.initState();
  }

  void onTapSubTrackHandle() {
    setState(() {
      if (cartCount > 1) {
        cartCount--;
      }
    });
  }

  void onTapAddHandle() {
    setState(() {
      cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight,
            color: Colors.grey,
          ),
          Container(
            padding: const EdgeInsets.only(left: 28, top: 25, right: 28),
            width: double.infinity,
            height: screenHeight / 2 + 20,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(30, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerRight),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(30, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerRight),
                      child: const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight / 2,
            width: screenWidth,
            height: screenHeight / 2,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category,
                    style: const TextStyle(
                        color: Color(0xff28B0CE),
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xffFFA902),
                        size: 30,
                      ),
                      Text(
                        '4.6 (89 reviews)',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.delivery_dining,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'FREE DELIVERY',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$$price',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColorDark),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '\$$discount',
                          style: const TextStyle(
                            color: Color(0xffBFC9DA),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 3,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: screenWidth / 10,
                                width: screenWidth / 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  border: Border.all(
                                    width: 0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    onTapSubTrackHandle();
                                  },
                                  child: Center(
                                      child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 28,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                  )),
                                ),
                              ),
                              Text(
                                cartCount.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: screenWidth / 10,
                                width: screenWidth / 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    onTapAddHandle();
                                  },
                                  child: Center(
                                      child: Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Theme.of(context).primaryColor),
                                  )),
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.grey,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: screenWidth / 10,
                    width: screenWidth / 2,
                    decoration: const BoxDecoration(
                      color: Color(0xffC29C1D),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(child: Text('20% OFF DISCOUNT')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Icon(Icons.shopping_cart,
                              size: 30,
                              color: Theme.of(context).primaryColorLight),
                        ),
                        Text(
                          textAddToCart.toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ],
                    ),
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
