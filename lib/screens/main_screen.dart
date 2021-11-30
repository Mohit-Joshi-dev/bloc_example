import 'package:bloc_example/screens/Home%20Screen/view.dart';
import 'package:bloc_example/utils/app_const.dart';
import 'package:flutter/material.dart';

import 'package:bloc_example/screens/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget currentLayout = HomeScreen();
  late String _tabSelected;
  late var _layoutType;

  @override
  void initState() {
    super.initState();
    _selectedTab('home');
  }

  void _selectedTab(String tab) {
    _tabSelected = tab;
    switch (_tabSelected) {
      case "home":
        _layoutType = HomeScreen();
        break;
      case "fav":
        _layoutType = FavouriteScreen();
        break;
      case "scan":
        _layoutType = ScanScreen();
        break;
      case "cart":
        _layoutType = CartScreen(
          popToHome: () {
            _selectedTab('home');
          },
        );
        break;
      case "profile":
        _layoutType = ProfileScreen();
        break;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutType,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6.0,
        elevation: 0,
        color: Colors.grey.shade100,
        shape: CircularNotchedRectangle(),
        child: Container(
            color: Colors.grey.shade100,
            width: screenWidth(context),
            height: 70,
            // padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _tabViewBottom("home", Icon(Icons.home_outlined, size: 30),
                        Icon(Icons.home, size: 30)),
                    _tabViewBottom(
                        "fav",
                        Icon(Icons.favorite_outline, size: 30),
                        Icon(Icons.favorite, size: 30)),
                    _tabViewBottom(
                        "scan",
                        Icon(Icons.qr_code, color: Colors.white, size: 30),
                        Icon(Icons.qr_code_scanner,
                            color: Colors.white, size: 30)),
                    _tabViewBottom(
                        "cart",
                        Icon(Icons.shopping_cart_outlined, size: 30),
                        Icon(Icons.shopping_cart, size: 30)),
                    _tabViewBottom(
                        "profile",
                        Icon(Icons.person_outline, size: 30),
                        Icon(Icons.person, size: 30)),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  _tabViewBottom(String tab, Icon icon, Icon iconSelected) {
    Widget view = Container(child: _tabSelected == tab ? iconSelected : icon);
    return InkWell(
      onTap: () => _selectedTab(tab),
      child: tab == 'scan'
          ? Container(
              height: 55,
              width: 55,
              alignment: Alignment.center,
              // padding: EdgeInsets.symmetric(vertical: 10),
              decoration:
                  BoxDecoration(color: themeColor, shape: BoxShape.circle),
              child: _tabSelected == tab ? iconSelected : icon,
            )
          : Container(
              // width: screenWidth(context) * 0.18,
              // height: screenWidth(context) * 0.17,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _tabSelected == tab ? iconSelected : icon),
    );
  }
}
