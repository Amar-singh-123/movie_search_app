import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.onPressed, required this.text, this.color, required this.isLoading, this.width, this.height});
final VoidCallback onPressed;
final String text;
final Color? color;
final bool isLoading;
final double? width;
final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? context.screenWidth * 0.85, height ?? 45),
        foregroundColor: context.themeColors.inversePrimary, backgroundColor: color ?? context.themeColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ), child: isLoading ? const CupertinoActivityIndicator() : Text(text),);
  }
}
