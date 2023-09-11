import 'package:flutter/material.dart';

// models
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';

// widgets
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.availableMeals, super.key});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final meals = availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return MealScreen(
          title: category.title,
          meals: meals,
        );
      }),
    );
  }

  @override
  Widget build(context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
