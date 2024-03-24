import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    required this.textInputType,
    required this.labelText,
    this.validator,
    this.onSaved,
    required this.valueKey,
    this.obscureText,
  });

  final TextInputType textInputType;
  final String labelText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String valueKey;
  final bool? obscureText;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(widget.valueKey),
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
