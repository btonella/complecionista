// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:complecionista/common/colors.dart';
import 'package:flutter/material.dart';

BottomNavigationBar defaultNavigationBar(int index, void Function(int)? onTap) {
  AppColors colors = getAppColors();
  return BottomNavigationBar(
    selectedItemColor: colors.mainColor(),
    unselectedItemColor: colors.secondColor(),
    currentIndex: index,
    type: BottomNavigationBarType.fixed,
    selectedFontSize: 12,
    onTap: onTap,
    items: [
      BottomNavigationBarItem(
        label: 'NOTÍCIAS',
        icon: Image.asset(
          'assets/icons/news.png',
          color: index == 0 ? colors.mainColor() : colors.secondColor(),
        ),
      ),
      BottomNavigationBarItem(
        label: 'VÍDEOS',
        icon: Image.asset(
          'assets/icons/video.png',
          color: index == 0 ? colors.mainColor() : colors.secondColor(),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Podcasts',
        icon: Image.asset(
          'assets/icons/podcast.png',
          color: index == 0 ? colors.mainColor() : colors.secondColor(),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Reviews',
        icon: Image.asset(
          'assets/icons/review.png',
          color: index == 0 ? colors.mainColor() : colors.secondColor(),
        ),
      ),
    ],
  );
}

AppBar defaultAppBar(BuildContext context,
    {String? title, bool hasLogo = false, bool automaticLead = true, bool hasLead = false, Icon? leadIcon, void Function()? leadFunction, List<Widget>? actions}) {
  AppColors colors = getAppColors();

  return AppBar(
    backgroundColor: colors.mainColor(),
    elevation: 0,
    title: hasLogo
        ? Image.asset(
            'assets/images/logo-white.png',
            height: 35,
            alignment: Alignment.center,
          )
        : Text(title ?? ''),
    actions: actions,
    leading: !automaticLead
        ? Container()
        : hasLead
            ? GestureDetector(onTap: leadFunction, child: leadIcon)
            : null,
  );
}
