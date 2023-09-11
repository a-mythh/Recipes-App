import 'package:flutter_riverpod/flutter_riverpod.dart';

// models
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // assign inital value to favorite meals list
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    // remove from favorite meals
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }
    // add to favorite meals
    else {
      state = [meal, ...state];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
