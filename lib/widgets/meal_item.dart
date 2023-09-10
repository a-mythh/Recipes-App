import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({required this.meal, required this.onSelectMeal, super.key});

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  String enumToString(Enum text) {
    return text.name[0].toUpperCase() + text.name.substring(1);
  }

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          return onSelectMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),

            // Meal Text Display
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black87,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Column(
                  children: [
                    // Meal name
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    const SizedBox(height: 10),

                    // Meal Item traits
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Time required to make the dish
                        MealItemTrait(
                          icon: Icons.alarm_rounded,
                          label: '${meal.duration.toString()} mins',
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        // Complexity of the dish
                        MealItemTrait(
                          icon: Icons.soup_kitchen_rounded,
                          label: enumToString(meal.complexity),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        // Cost of the dish
                        MealItemTrait(
                          icon: Icons.monetization_on,
                          label: enumToString(meal.affordability),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
