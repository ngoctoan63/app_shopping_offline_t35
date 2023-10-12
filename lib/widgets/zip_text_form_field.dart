import 'package:flutter/material.dart';

class ZipTextFormField extends StatefulWidget {
  const ZipTextFormField({
    super.key,
    required this.controller,
    this.onTap,
    this.labelText = '',
    this.hintText = '',
    this.readonly = false,
    this.textInputType = TextInputType.text,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool readonly;
  final TextInputType textInputType;
  final VoidCallback? onTap;
  @override
  State<ZipTextFormField> createState() => _ZipTextFormFieldState();
}

class _ZipTextFormFieldState extends State<ZipTextFormField> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readonly,
      keyboardType: widget.textInputType,
      focusNode: focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: Theme.of(context).primaryColorDark.withOpacity(0.5)),
        labelText: widget.labelText,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(10),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Theme.of(context).primaryColor),
        ),
      ),
      style: TextStyle(color: Theme.of(context).primaryColorDark),
    );
  }
}
