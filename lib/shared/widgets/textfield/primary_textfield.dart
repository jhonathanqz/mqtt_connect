import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    Key? key,
    this.label,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
      ),
    );
  }
}
