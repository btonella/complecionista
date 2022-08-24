import 'package:complecionista/common/widgets/side_menu.dart';
import 'package:complecionista/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: defaultSideMenu(context),
      appBar: defaultAppBar(context, title: 'Games'),
      body: Column(
        children: const [
          Text('events'),
        ],
      ),
    );
  }
}
