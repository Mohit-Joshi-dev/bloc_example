import 'package:bloc_example/components/item_card.dart';
import '../placeholders/items.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favItems.isEmpty
          ? Center(
              child: Text(
              'No favourite items found',
              style: TextStyle(fontWeight: FontWeight.w600),
            ))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemCount: favItems.length,
              itemBuilder: (context, index) {
                return ItemCard(
                    setState: () {
                      setState(() {});
                    },
                    item: favItems[index]);
              }),
    );
  }
}
