import 'package:bloc_example/models/item.dart';
import 'package:bloc_example/placeholders/items.dart';
import 'package:bloc_example/screens/item_detail_screen.dart';
import 'package:bloc_example/utils/app_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final Function setState;
  const ItemCard({
    Key? key,
    required this.setState,
    required this.item,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => DetailScreen(item: widget.item)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            // height: 270,
            // padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.shutterstock.com/image-photo/white-armchair-isolated-on-background-260nw-101575315.jpg",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 200,
                        )),
                    Text(widget.item.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 22),
                        Text("4.9",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.attach_money,
                            color: Colors.yellow, size: 22),
                        Text(widget.item.price.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 30),
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeColor,
                            ),
                            padding: EdgeInsets.all(4),
                            child:
                                Icon(Icons.chevron_right, color: Colors.white))
                      ],
                    )
                  ],
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: widget.item.isFav
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.item.isFav = false;
                            });
                            if (favItems.contains(widget.item)) {
                              favItems.remove(widget.item);
                              widget.setState();
                              debugPrint('Items removed from Favourites');
                            }
                          },
                          child: Icon(
                            Icons.favorite,
                            color: themeColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.item.isFav = true;
                            });
                            if (!favItems.contains(widget.item)) {
                              favItems.add(widget.item);
                              widget.setState();
                              debugPrint('Items removed from Favourites');
                            }
                          },
                          child: Icon(
                            Icons.favorite_border,
                            color: themeColor,
                          ),
                        ),
                )
              ],
            )),
      ),
    );
  }
}
