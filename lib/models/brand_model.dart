import 'package:flutter/material.dart';
import '../data/items_data.dart';
import 'items_model.dart';

class BrandFilterModel extends ChangeNotifier {
  List<ItemsModel> _filteredList = ItemsList;
  double _currentPage = 0.0;

  List<ItemsModel> get filteredList => _filteredList;
  double get currentPage =>_currentPage;

  set filteredList(List<ItemsModel> filter) {
    _filteredList = filter;
    notifyListeners();
  }
  set currentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }
}
