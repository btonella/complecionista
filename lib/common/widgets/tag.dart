import 'package:complecionista/common/colors.dart';
import 'package:complecionista/common/theme.dart';
import 'package:flutter/material.dart';

Widget getTag(String title, {bool hasTopMargin = true}) {
  AppColors appColors = getAppColors();
  return Container(
    decoration: BoxDecoration(
      color: appColors.mainColor(),
      borderRadius: const BorderRadius.all(Radius.circular(9)),
    ),
    child: Container(
      margin: hasTopMargin ? const EdgeInsets.all(5) : const EdgeInsets.only(top: 5, bottom: 5, right: 5),
      child: Text(
        title.toUpperCase(),
        style: defaultTextTheme.bodyText1?.copyWith(fontSize: 9, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
