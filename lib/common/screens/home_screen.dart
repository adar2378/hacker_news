import 'package:flutter/material.dart';
import 'package:hacker_news/modules/news_module/screens/news_screen.dart';
import 'package:hacker_news/modules/search_module/screens/search_screen.dart';
import 'package:hacker_news/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [NewScreen(), SearchScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
              blurRadius: 4,
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          selectedItemColor: HNColors.primaryColor,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Top Stories")),
            BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
          ],
        ),
      ),
    );
  }
}
