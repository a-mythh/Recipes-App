import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

// models
import 'package:meals_app/models/meal.dart';

// screens
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';

// widgets
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _favoriteMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilters;

  Future<void> _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,)),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      behavior: SnackBarBehavior.floating,
      elevation: 20,
      width: 220,
      dismissDirection: DismissDirection.horizontal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer favorite :(');
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as favorite!');
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filters.glutenFree]!) {
        return false;
      }

      if (!meal.isLactoseFree && _selectedFilters[Filters.lactoseFree]!) {
        return false;
      }

      if (!meal.isVegetarian && _selectedFilters[Filters.vegetarian]!) {
        return false;
      }

      if (!meal.isVegan && _selectedFilters[Filters.vegan]!) return false;

      return true;
    }).toList();

    String selectedPageTitle = 'Categories';
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      selectedPageTitle = 'Your Favorites';
      activeScreen = MealScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      drawerEdgeDragWidth: 50,
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        enableFeedback: true,
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded), label: 'Favorites'),
        ],
      ),
    );
  }
}
