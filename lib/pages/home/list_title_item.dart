import 'package:flutter/material.dart';

class ListTitleItem extends StatelessWidget {
  ListTitleItem({
    super.key,
    required this.title,
    this.prefixIcon,
    required this.onTap,
  });
  String title;
  final VoidCallback onTap;
  var prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(prefixIcon),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onTap();
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(30, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight),
          child: Icon(
            Icons.chevron_right,
            color: Theme.of(context).primaryColorDark,
            size: 30,
          ),
        ),
      ],
    );
  }
}
