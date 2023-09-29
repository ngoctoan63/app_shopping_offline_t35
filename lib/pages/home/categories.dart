import 'package:denshihanbai/utilities/ultilities_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apps/const/value.dart';
import '../../apps/routers/router_name.dart';
import '../../provider/data_provider.dart';
import '../../widgets/category_item_widget.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textCategories,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColorDark),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouterName.productCategories);
              },
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(30, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerRight),
              child: const Icon(
                Icons.chevron_right,
                color: Color(0xff7D8FAB),
                size: 30,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: width / 4,
        child: Column(
          children: [
            Consumer<DataProvider>(
              builder: (_, dataProvider, __) => Expanded(
                  child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dataProvider.categoriesList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: width / 4,
                    decoration: BoxDecoration(
                      color: colorCategories[index],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: categoryItemWidget(
                        categoryID: 'caterogy$index',
                        title: dataProvider.categoriesList[index].capitalize(),
                        assetImagePath:
                            'assets/images/categories/${dataProvider.categoriesList[index]}.png',
                        itemsCount: 45,
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      )
    ]);
  }
}
