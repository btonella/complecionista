import 'package:complecionista/common/colors.dart';
import 'package:complecionista/modules/feed/presenter/books.dart';
import 'package:complecionista/modules/feed/presenter/events.dart';
import 'package:complecionista/modules/feed/presenter/games.dart';
import 'package:complecionista/modules/feed/presenter/movies.dart';
import 'package:complecionista/modules/feed/presenter/series.dart';
import 'package:complecionista/modules/feed/presenter/shop.dart';
import 'package:flutter/material.dart';

Widget defaultSideMenu(BuildContext context) {
  AppColors appColors = getAppColors();
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.55,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Drawer(
        backgroundColor: appColors.mainColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.center,
              child: Image.asset('assets/images/yellow-d20.png', height: 60),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  sideMenuIcon(
                    context,
                    name: 'Games',
                    icon: 'games',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const GamesPage()));
                    },
                  ),
                  sideMenuIcon(
                    context,
                    name: 'Cinema',
                    icon: 'movies',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const MoviesPage()));
                    },
                  ),
                  sideMenuIcon(
                    context,
                    name: 'Séries',
                    icon: 'series',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SeriesPage()));
                    },
                  ),
                  sideMenuIcon(
                    context,
                    name: 'Livros e HQs',
                    icon: 'books',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const BooksPage()));
                    },
                  ),
                  sideMenuIcon(
                    context,
                    name: 'Eventos',
                    icon: 'events',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const EventsPage()));
                    },
                  ),
                  sideMenuIcon(
                    context,
                    name: 'Loja',
                    icon: 'shop',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const ShopPage()));
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: appColors.grey()),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: 18,
                      color: appColors.grey(),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.settings_outlined,
                    size: 20,
                    color: appColors.grey(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget sideMenuIcon(BuildContext context, {required String name, required String icon, required void Function()? onTap, bool isLast = false}) {
  AppColors appColors = getAppColors();
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/icons/$icon.png',
                  height: 25,
                ),
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16, color: appColors.black()),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            height: 1,
            color: appColors.grey().withOpacity(0.3),
          ),
        )
      ],
    ),
  );
}
