import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';

import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = '/favorite';
  final List<Meal> favoriteMeals;
  const FavoriteScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    }
    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (context, index) {
        return MealItem(
          id: favoriteMeals[index].id,
          imageUrl: favoriteMeals[index].imageUrl,
          title: favoriteMeals[index].title,
          duration: favoriteMeals[index].duration,
          affordability: favoriteMeals[index].affordability,
          complexity: favoriteMeals[index].complexity,
          removeItem: null,
        );
      },
    );
  }
}
