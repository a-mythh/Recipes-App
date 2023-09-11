import 'package:flutter_riverpod/flutter_riverpod.dart';

// data
import 'package:meals_app/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
