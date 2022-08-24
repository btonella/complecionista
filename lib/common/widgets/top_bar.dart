import 'package:complecionista/common/colors.dart';
import 'package:complecionista/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

Widget commonTopBar(BuildContext context, {required List<Widget> content, bool hasLogo = true}) {
  double distance = 150.0;
  AppColors appColors = getAppColors();

  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 50),
        height: 50,
        decoration: BoxDecoration(color: appColors.mainColor()),
        alignment: Alignment.topCenter,
        child: SizedBox.expand(
          child: Image.asset(
            'assets/images/logo-white.png',
            alignment: Alignment.center,
          ),
        ),
      ),
      Positioned(
        top: distance,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: appColors.black(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // children: [],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: distance + 30.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: content,
          ),
        ),
      ),
      defaultAppBar(context, hasLogo: hasLogo)
    ],
  );
}
