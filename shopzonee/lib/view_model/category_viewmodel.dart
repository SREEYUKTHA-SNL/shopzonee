import 'package:flutter/material.dart';

import 'package:shopzonee/model/category_model.dart';
import 'package:shopzonee/services/categortservice.dart';

// Import ApiService

class CategoryViewmodel extends ChangeNotifier {
  final CategoryService categoryService = CategoryService();

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      // Use ApiService to fetch categories
      _categories = await categoryService.viewCategory();

      print(_categories);
    } catch (error) {
      print("Error fetching categories: $error");
    } finally {
      _isLoading = false; // Set loading to false in finally block
      notifyListeners(); // Notify listeners about the change
    }
  }
}