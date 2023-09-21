import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  InputField({
    super.key,
    this.hintText = "",
    this.labelText = "",
    this.helperText = "",
    this.isSecure = false,
    this.prefixIcon,
    required this.controller,
  });

  final String hintText;
  final String labelText;
  final String helperText;
  bool isSecure;
  var prefixIcon;

  TextEditingController controller;
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isSecure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      style: const TextStyle(
        fontSize: 18,
        color: Color(0xFF293041),
      ), //TextStyle(color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xFFE8EFF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: const Color(0xFFE8EFF3),
        focusColor: Theme.of(context).primaryColor,
        hintText: widget.hintText,
        floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        helperText: widget.helperText,
        // iconColor: Theme.of(context).primaryColor,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? Theme.of(context).primaryColor : Colors.grey),
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        suffixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? Theme.of(context).primaryColor : Colors.grey),
      ),
    );
  }
}
