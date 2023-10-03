import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apps/const/value.dart';
import '../../provider/data_provider.dart';
import '../../widgets/popular_deal_item.dart';

class PopularDeal extends StatelessWidget {
  const PopularDeal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  textPopularDeals,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Consumer<DataProvider>(
                      builder: (_, dataProvider, __) => Expanded(
                        child: GridView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.55,
                          ),
                          itemCount: dataProvider.popularDeals.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PopularDealItem(
                              title: dataProvider.popularDeals[index]["title"],
                              imgPath: dataProvider.popularDeals[index]
                                  ["image_path"],
                              price: dataProvider.popularDeals[index]["price"],
                              likeCount: dataProvider.popularDeals[index]
                                  ["likeCount"],
                              disCount: dataProvider.popularDeals[index]
                                  ["discount"],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
