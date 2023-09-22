import 'package:flutter/material.dart';

import '../apps/const/value.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.isFill = true,
    this.enable = true,
  });
  String title;
  bool isFill;
  bool enable;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: isFill
            ? BoxDecoration(
                color: enable ? Theme.of(context).primaryColor : Colors.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                boxShadow: [
                    BoxShadow(
                      color: enable
                          ? Theme.of(context).primaryColor.withOpacity(0.4)
                          : Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 10),
                    )
                  ])
            : BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.0,
              color: isFill ? Colors.white : Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
