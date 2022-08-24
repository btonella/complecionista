import 'package:complecionista/common/widgets/side_menu.dart';
import 'package:complecionista/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({Key? key}) : super(key: key);

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: defaultSideMenu(context),
      appBar: defaultAppBar(context, title: 'Séries'),
      body: Column(
        children: const [
          Text('séries'),
        ],
      ),
    );
  }
}
