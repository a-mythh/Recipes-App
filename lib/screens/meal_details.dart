import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// providers

// models
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({required this.meal, super.key});

    final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) 
  {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(title: Text(meal.title), actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  wasAdded ? 'Marked as favorite!' : 'Meal has been removed :(',
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                behavior: SnackBarBehavior.floating,
                elevation: 20,
                width: 220,
                dismissDirection: DismissDirection.horizontal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ));
            },
            icon: Icon(isFavorite ? Icons.star_rounded : Icons.star_border_rounded),
          ),
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
              const SizedBox(height: 15),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 15),
              // Ingredients
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final ingredient in meal.ingredients)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          '•   $ingredient',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Steps
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (index, steps) in meal.steps.indexed)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Text(
                          '${index + 1}. $steps',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
