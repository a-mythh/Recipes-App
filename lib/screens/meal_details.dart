import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({required this.meal, required this.onToggleFavorite, super.key});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(meal.title), actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(meal);
            },
            icon: const Icon(Icons.star_border_rounded),
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
