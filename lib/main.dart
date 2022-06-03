import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealapp/screens/category_meal_screen.dart';
import 'package:mealapp/screens/filter_screen.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/shared/colors.dart';

import 'data/dummy_data.dart';
import 'models/meal.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: canvasColor));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              elevation: 0,
              iconTheme: const IconThemeData(color: textColor),
              titleTextStyle: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: canvasColor,
                  statusBarIconBrightness: Brightness.light)),
          cardColor: card,
          fontFamily: 'RobotoCondensed',
          textTheme: const TextTheme(
            bodyText2: TextStyle(
                color: Color.fromRGBO(250, 240, 206, 1.0),
                fontSize: 16,
                fontWeight: FontWeight.bold),
            bodyText1: TextStyle(
                color: Color.fromRGBO(253, 245, 224, 1.0), fontSize: 18),
            subtitle1: TextStyle(
                color: Color.fromRGBO(17, 52, 52, 1.0),
                fontSize: 24,
                fontWeight: FontWeight.bold),
            subtitle2: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            headline4: TextStyle(
              color: Color.fromRGBO(253, 245, 224, 1.0),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            headline5: TextStyle(
              color: Color.fromRGBO(253, 245, 224, 1.0),
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: canvasColor,
              foregroundColor: textColor,
              elevation: 16,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(250, 240, 206, 1.0)),
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: createMaterialColor(canvasColor))
              .copyWith(secondary: Colors.purple),
          canvasColor: canvasColor,
          primaryColor: createMaterialColor(textColor),
          primarySwatch: createMaterialColor(primaryColor)),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(
              availableMeal: _availableMeal,
            ),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(_setFilters, _filters),
      },
    );
  }
}
