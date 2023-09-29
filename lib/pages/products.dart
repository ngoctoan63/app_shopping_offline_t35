import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../apps/const/value.dart';

class ProductPage extends StatelessWidget {
  ProductPage({
    super.key,
    required this.categoryID,
    required this.title,
  });
  String categoryID;
  String title;
  String searchKey = "";
  int page = 1;
  Timer? timer1;
  final TextEditingController _textEditingController = TextEditingController();
  void handleOnChange(String value) {
    page = 1;
    searchKey = value;
    if (timer1 != null) {
      timer1!.cancel();
    }
    timer1 = Timer(const Duration(seconds: 1), () {});
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 28, top: 25, right: 25),
          height: 50,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
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
                    color: Color(0xff7D8FAB),
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColorDark),
                ),
              ],
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
                    Icons.filter_alt_rounded,
                    color: Color(0xff7D8FAB),
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
                    color: Color(0xff7D8FAB),
                    size: 30,
                  ),
                ),
              ],
            ),
          ]),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
          child: TextField(
            onChanged: (value) {
              handleOnChange(value);
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: textSearchBeveragesOrFoods,
              suffixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey.shade500,
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: inputCustomBorder(),
              enabledBorder: inputCustomBorder(),
              disabledBorder: inputCustomBorder(),
            ),
            style: const TextStyle(fontSize: 20, color: Colors.black),
            maxLines: 1,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ]),
    );
  }
}

InputBorder inputCustomBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(10.0));
}
