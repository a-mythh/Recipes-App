import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({required this.onSelectScreen, super.key});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
              Theme.of(context).colorScheme.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Row(
            children: [
              Icon(
                Icons.fastfood_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 18),
              Text(
                'Cooking Up!',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.restaurant_rounded),
          title: Text(
            'Meals',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            onSelectScreen('meals');
          }
        ),
        ListTile(
          leading: const Icon(Icons.filter_list_rounded),
          title: Text(
            'Filters',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            onSelectScreen('filters');
          }
        ),
      ]),
    );
  }
}
