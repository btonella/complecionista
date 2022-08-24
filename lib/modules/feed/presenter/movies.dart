import 'package:complecionista/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Filmes'),
      body: Column(
        children: const [
          Text('filmes'),
        ],
      ),
    );
  }
}
