import 'package:flutter/material.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {super.key,
      required this.controller,
      required this.hint,
       this.label,
       this.enabled = true,
      required this.validator,
      this.maxLines,
      this.labelStyle});

  final TextEditingController controller;
  final String hint;
  final String? label;
  final bool enabled;
  final String? Function(String? value) validator;
  final int? maxLines;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        validator: validator,
        maxLines: maxLines,
        style:  TextStyle(color: context.themeColors.primary),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          hintStyle:  TextStyle(color: context.themeColors.primary),
          labelStyle: labelStyle ?? TextStyle(color: context.themeColors.primary),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: 15.borderRadius,
            borderSide: BorderSide(color: context.themeColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: 15.borderRadius,
            borderSide: BorderSide(color: context.themeColors.primary),
          ),
        ),
      ),
    );
  }
}
