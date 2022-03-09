import 'package:flutter/material.dart';

class ItemsModel {
  final String images;
  Color background;
  Color textTitleColor = Colors.white;
  Color textPriceColor = Colors.white;
  final String category;
  final String title;
  final String brand;
  final description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  final double price;

  ItemsModel(
      this.images, this.background, this.category, this.title, this.price, this.brand);
}
