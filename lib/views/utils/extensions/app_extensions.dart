import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension Spaces on int {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );

  SizedBox get width => SizedBox(
        width: toDouble(),
      );

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());

  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());

  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());

  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());

  EdgeInsets get allMargin => EdgeInsets.all(toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get horizontalMargin =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get verticalMargin => EdgeInsets.symmetric(vertical: toDouble());

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  RoundedRectangleBorder get shapeBorderRadius =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(toDouble()));
}

extension ContextFormates on BuildContext {
  ColorScheme get themeColors => Theme.of(this).colorScheme;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.width;
}

extension Formates on String {
  String get formatDate {
    try {
      DateTime date = DateTime.parse(this ?? '');
      return DateFormat('MMM dd yyyy').format(date);
    } catch (e) {
      return "Invalid date";
    }
  }
  String get formateCategoryName {
   var data = split('_');
   return data.join(' ').capitalize.toString();
  }
  String get generateImageUrl {
    return "https://image.tmdb.org/t/p/w500$this";
  }
}

