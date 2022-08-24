import 'package:complecionista/common/colors.dart';
import 'package:complecionista/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<String> names = ['Notícias', 'Vídeos', 'Podcasts', 'Reviews'];

BottomAppBar bottomAppBar(BuildContext context, String activeRoute) {
  AppColors appColors = getAppColors();
  double width = MediaQuery.of(context).size.width;
  double buttonWidth = width / 5;

  return BottomAppBar(
    color: appColors.mainColor(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _appBarButton(
          'news',
          activeRoute,
          0,
          buttonWidth,
          () => Modular.to.pushReplacementNamed('/news'),
        ),
        _appBarButton(
          'videos',
          activeRoute,
          1,
          buttonWidth,
          () => Modular.to.pushReplacementNamed('/videos'),
        ),
        _appBarButton(
          'podcasts',
          activeRoute,
          2,
          buttonWidth,
          () => Modular.to.pushReplacementNamed('/podcasts'),
        ),
        _appBarButton(
          'reviews',
          activeRoute,
          3,
          buttonWidth,
          () => Modular.to.pushReplacementNamed('/reviews'),
        ),
      ],
    ),
  );
}

Widget _appBarButton(String name, String active, int index, double size, Function()? onTap) {
  AppColors appColors = getAppColors();
  var button = Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    height: 60,
    width: size,
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icons/$name.png',
            color: name == active ? appColors.black() : appColors.grey(),
            height: 32,
          ),
          Text(
            names[index],
            style: defaultTextTheme.subtitle1?.copyWith(
              color: name == active ? appColors.black() : appColors.grey(),
              fontSize: 11,
            ),
          )
        ],
      ),
    ),
  );
  return button;
}
