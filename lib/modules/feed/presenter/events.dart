import 'package:complecionista/common/side_menu.dart';
import 'package:complecionista/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: defaultSideMenu(context),
      appBar: defaultAppBar(context, title: 'Eventos'),
      body: Column(
        children: const [
          Text('events'),
        ],
      ),
    );
  }
}
