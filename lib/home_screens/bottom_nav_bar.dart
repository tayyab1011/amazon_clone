import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/home_screens/account_screen.dart';
import 'package:amazon_clone/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pages = 0;
  double bottomNavWidth = 42;
  double bottomBorderWidth = 5;
  List<Widget> screens = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text("data"),)

  ];
  void updatePage(int page){
    setState(() {
      _pages = page;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_pages],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        currentIndex: _pages,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: "",
              icon: Container(
            width: bottomNavWidth,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      width: bottomBorderWidth,
                        color: _pages == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor))),
                            child: const Icon(Icons.home_outlined),
          )
          
          ),
           BottomNavigationBarItem(
            label: "",
              icon: Container(
            width: bottomNavWidth,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      width: bottomBorderWidth,
                        color: _pages == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor))),
                            child: const Icon(Icons.person_2_outlined),
          )
          
          ),
           BottomNavigationBarItem(
            label: "",
              icon: Container(
            width: bottomNavWidth,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      width: bottomBorderWidth,
                        color: _pages == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor))),
                         
                      
                              child: const badges.Badge(
                                badgeContent: Text('2'),
                                badgeStyle: badges.BadgeStyle(
                                  elevation: 0,
                                  badgeColor: Colors.white
                                ),
                                child: Icon(Icons.shopping_cart_outlined)),
          )
          
          )
        ],
      ),
    );
  }
}
