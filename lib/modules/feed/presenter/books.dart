import 'package:complecionista/common/widgets/appbar.dart';
import 'package:complecionista/common/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: defaultSideMenu(context),
      appBar: defaultAppBar(context, title: 'Livros e HQs'),
      body: Column(
        children: const [
          Text('books'),
        ],
      ),
    );
  }
}
