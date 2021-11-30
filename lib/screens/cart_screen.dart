import 'package:bloc_example/models/item.dart';
import 'package:bloc_example/placeholders/cart_placeholder.dart';
import 'package:bloc_example/utils/app_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  final Function popToHome;
  const CartScreen({
    Key? key,
    required this.popToHome,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _height = 60;
  late Widget checkoutButton;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    switch (isExpanded) {
      case true:
        _height = 300;
        checkoutButton = expandedCheckoutButton();
        break;
      case false:
        _height = 80;
        checkoutButton = baseCheckout();
        break;
      default:
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'My Cart',
          style: GoogleFonts.ubuntu(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeColor,
          ),
        ),
        centerTitle: true,
        leadingWidth: 60,
        leading: GestureDetector(
          onTap: () => widget.popToHome(),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: themeColor),
              child: Icon(Icons.chevron_left, size: 28, color: Colors.white),
            ),
          ),
        ),
        actions: [
          Icon(Icons.delete_outline_outlined, size: 36, color: Colors.grey),
          SizedBox(width: 20)
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
              'No Items found in the cart',
              style: TextStyle(fontWeight: FontWeight.w600),
            ))
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return buildItem(cartItems[index]);
              },
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: AnimatedContainer(
          // decoration: ,
          duration: Duration(milliseconds: 0),
          height: _height,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: checkoutButton),
        ),
      ),
    );
  }

  Widget baseCheckout() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 10),
      // height: 1000,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.grey.shade100),
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
            'Checkout',
            style: GoogleFonts.ubuntu(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget expandedCheckoutButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      // height: 500,
      // height: _height,
      // height: 1000,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.grey.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 8,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
          amountView('Subtotal', '4000'),
          amountView('Delivery & handling', '300'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          amountView('Subtotal', '4300'),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 50,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: themeColor,
              ),
              alignment: Alignment.center,
              child: Text(
                'Checkout',
                style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget amountView(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: Text(title,
                  style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.grey))),
          Text('\$' + amount,
              style: GoogleFonts.ubuntu(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget buildItem(Item item) {
    return Dismissible(
      key: Key(item.title),
      onDismissed: (direction) {
        if (cartItems.contains(item)) cartItems.remove(item);
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${item.title} removed"),
          duration: Duration(milliseconds: 500),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://image.shutterstock.com/image-photo/white-armchair-isolated-on-background-260nw-101575315.jpg",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
              SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(item.title,
                      style:
                          GoogleFonts.ubuntu(fontSize: 20, color: themeColor)),
                  Text('\$ ' + item.price.toString(),
                      style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (item.quantity <= 1) {
                            if (cartItems.contains(item))
                              cartItems.remove(item);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${item.title} removed"),
                              duration: Duration(milliseconds: 500),
                            ));
                          } else {
                            item.quantity--;
                            setState(() {});
                          }
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade100),
                            child: Icon(Icons.remove, color: Colors.grey)),
                      ),
                      Container(
                          height: 40,
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(item.quantity.toString(),
                              style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ))),
                      GestureDetector(
                        onTap: () {
                          item.quantity++;
                          setState(() {});
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: themeColor),
                            child: Icon(Icons.add, color: Colors.white70)),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
