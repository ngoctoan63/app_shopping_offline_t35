import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.Title,
    required this.onTap,
  });

  final String Title;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenWidth / 10,
      width: screenWidth / 10,
      child: ElevatedButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColorLight,
            elevation: 2,
            backgroundColor: Theme.of(context).primaryColor),
        child: Text(Title),
      ),
    );
  }
}
