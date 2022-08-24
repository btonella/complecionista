import 'package:complecionista/common/widgets/side_menu.dart';
import 'package:complecionista/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: defaultSideMenu(context),
      appBar: defaultAppBar(context, title: 'Loja'),
      body: Column(
        children: const [
          Text('loja'),
        ],
      ),
    );
  }
}
