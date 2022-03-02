import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../../models/items_model.dart';

///@brief Main Card for Items
class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.itemsList,
    required this.i,
    required this.scale,
    required this.width, required this.onTap,
  }) : super(key: key);

  final List<ItemsModel> itemsList;
  final int i;
  final double scale;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var sizeItemsPicture = width * 0.80;
    double transform = (1 - 0.30 * scale).clamp(0, 1);
    return Container(
      width: width,
      margin: const EdgeInsets.only(left: kPadding * 2),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: itemsList[i].background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 25, right: 10, left: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemsList[i].title,
                            style: const TextStyle(
                                letterSpacing: 1.5,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Roboto'),
                          ),
                          const SizedBox(height: 5),
                          Text('\$${itemsList[i].price.toString()}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400))
                        ]))),
            Positioned(
                bottom: 20,
                right: 0,
                child: Hero(
                    tag: itemsList[i].images,
                    child: Transform(
                      alignment: Alignment.bottomLeft,
                      transform: Matrix4.identity()..scale(transform, transform),
                      child: Image.asset(itemsList[i].images,
                          width: sizeItemsPicture, fit: BoxFit.fill),
                    ))),
          ],
        ),
      ),
    );
  }
}

/// @brief Popular Card for the Home Page
class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.itemsList,
    required this.i,
  }) : super(key: key);

  final List<ItemsModel> itemsList;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Hero(
              tag: itemsList[i].images,
              child: Image.asset(itemsList[i].images, fit: BoxFit.contain)),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemsList[i].title,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    overflow: TextOverflow.ellipsis,
                  )),
              const SizedBox(height: 15),
              Text('\$${itemsList[i].price.toString()}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ],
    );
  }
}
