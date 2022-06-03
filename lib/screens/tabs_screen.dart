import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/shared/colors.dart';

import '../widgets/main_drawer.dart';
import 'category_screen.dart';
import 'favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  const TabsScreen(this._favoriteMeals, {Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  @override
  initState() {
    _pages = [
      {
        'page': const CategoryScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(widget._favoriteMeals),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("${_pages[_selectedPageIndex]['title']}"),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: card.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, -1),
              ),
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 50,
            currentIndex: _selectedPageIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: _selectPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: "Category",
                activeIcon: Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "Favorite",
                activeIcon: Icon(Icons.favorite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
