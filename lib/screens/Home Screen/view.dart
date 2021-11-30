import 'package:bloc_example/components/item_card.dart';
import 'package:bloc_example/placeholders/items.dart';
import 'package:bloc_example/screens/Home%20Screen/popular_item_card.dart';
import 'package:bloc_example/utils/app_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _currentSelectedChip = _chips[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: ListView(physics: BouncingScrollPhysics(), children: [
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: Text('Best Furniture\nFor Your House',
                  style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32)),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: Colors.grey.shade300, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Search furniture',
                          style: GoogleFonts.ubuntu(
                              color: Colors.grey.shade300, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: themeColor),
                  height: 60,
                  width: 60,
                  child: Icon(
                    Icons.sync_alt,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,
                  itemCount: _chips.length,
                  itemBuilder: (context, index) {
                    bool _currentIndex =
                        _chips.indexOf(_currentSelectedChip) == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentSelectedChip = _chips[index];
                          _currentIndex =
                              _chips.indexOf(_currentSelectedChip) == index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex ? themeColor : Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu,
                                  color: _currentIndex
                                      ? Colors.white
                                      : Colors.grey),
                              SizedBox(width: 10),
                              Text(_chips[index],
                                  style: GoogleFonts.ubuntu(
                                      color: _currentIndex
                                          ? Colors.white
                                          : Colors.grey))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(height: 20),
          mainItemsListView(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text('Popular',
                style: GoogleFonts.ubuntu(
                    fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          popularItemsListView()
        ]),
      ),
    );
  }

  Padding popularItemsListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 100,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return PopularItemCard(
                index: index,
                setState: () {
                  setState(() {});
                },
              );
            }),
      ),
    );
  }

  Container mainItemsListView() {
    return Container(
      height: 270,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ItemCard(
              item: items[index],
              setState: () {
                setState(() {});
              },
            );
          }),
    );
  }

  int tag = 1;
  List<bool> options = [];
  List<String> _chips = ['Armchair', 'Bed', 'Cupboard'];
  late String _currentSelectedChip;
}
