import 'package:flutter/material.dart';
import '../pages/products.dart';

class categoryItemWidget extends StatelessWidget {
  categoryItemWidget({
    super.key,
    required this.categoryID,
    required this.title,
    this.assetImagePath = '',
    this.itemsCount = 0,
    this.fSize = 14,
  });
  String categoryID;
  String assetImagePath;
  String title;
  int itemsCount;
  double fSize;

  void _handleOnClick(context) {
    print(title);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ProductPage(
              categoryID: categoryID,
              title: title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleOnClick(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(assetImagePath), //
          Column(
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: fSize),
              ),
              Text(
                '$itemsCount items',
                style: TextStyle(color: Colors.white, fontSize: fSize),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
