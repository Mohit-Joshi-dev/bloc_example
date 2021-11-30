import 'package:bloc_example/placeholders/items.dart';
import 'package:bloc_example/utils/app_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularItemCard extends StatefulWidget {
  final int index;
  final Function setState;
  const PopularItemCard({
    Key? key,
    required this.setState,
    required this.index,
  }) : super(key: key);

  @override
  _PopularItemCardState createState() => _PopularItemCardState();
}

class _PopularItemCardState extends State<PopularItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Stack(
            children: [
              Row(
                children: [
                  chairImage,
                  SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[widget.index].title,
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
                          Text(items[widget.index].price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 30)
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 5,
                top: 10,
                child: items[widget.index].isFav
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            items[widget.index].isFav = false;
                          });
                          if (favItems.contains(items[widget.index])) {
                            favItems.remove(items[widget.index]);
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
                            items[widget.index].isFav = true;
                          });
                          if (!favItems.contains(items[widget.index])) {
                            favItems.add(items[widget.index]);
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
    );
  }

  Widget chairImage = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl:
            "https://image.shutterstock.com/image-photo/white-armchair-isolated-on-background-260nw-101575315.jpg",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: 200,
      ));
}
