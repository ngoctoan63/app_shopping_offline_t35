import 'package:denshihanbai/utilities/ultilities_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apps/const/value.dart';
import '../apps/routers/router_name.dart';
import '../provider/data_provider.dart';
import '../widgets/category_item_widget.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 28, top: 25, right: 25),
            height: 100,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(30, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xff7D8FAB),
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      textCategories,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColorDark),
                    ),
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
                    color: Color(0xff7D8FAB),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              width: double.infinity,
              // height: height * 0.9,
              child: Consumer<DataProvider>(
                builder: (context, dataProvider, child) => GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: width * 0.06,
                    crossAxisSpacing: width * 0.06,
                    crossAxisCount: width > 600 ? 4 : 2,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: dataProvider.categoriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: colorCategories[index],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: categoryItemWidget(
                        categoryID: 'caterogy$index',
                        title: dataProvider.categoriesList[index].capitalize(),
                        assetImagePath:
                            'assets/images/categories/${dataProvider.categoriesList[index]}.png',
                        itemsCount: 45,
                        fSize: 18,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
