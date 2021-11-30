import 'package:bloc_example/models/item.dart';
import 'package:bloc_example/placeholders/cart_placeholder.dart';
import 'package:bloc_example/utils/app_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final Item item;
  const DetailScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomAppBar(
        elevation: 0,
        child: cartItems.contains(widget.item)
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  if (!cartItems.contains(widget.item)) {
                    cartItems.add(widget.item);
                    widget.item.quantity = 1;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${widget.item.title} added to cart"),
                      duration: Duration(milliseconds: 1000),
                    ));
                  }
                },
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    // color: Colors.grey.shade100,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: themeColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Add To Cart',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
      ),
      body: Column(
        children: [
          Expanded(
              child: CachedNetworkImage(
            imageUrl:
                "https://image.shutterstock.com/image-photo/white-armchair-isolated-on-background-260nw-101575315.jpg",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            // height: 200,
          )),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(
                    '- Modern Fabric Accent Chair made for cosying up after work, power naps and more; sports a lightweight design that adapts to tea parties with wine, long due catchups with friends and baby time',
                    style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text(
                    '- Meets European Safety Standard EN 12520; safe design free of toxins and harmful chemicals Built for convenience; has optimal ground clearance to ensure easy retrieval of toys and hassle-free cleaning',
                    style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text(
                    '- Passed durability testing through 25000 cycles; supports 95 kg on seats and 40 kg on backrest',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
