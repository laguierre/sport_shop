import 'package:flutter/cupertino.dart';
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
    required this.width,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  final List<ItemsModel> itemsList;
  final int i;
  final double scale;
  final double width;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    var sizeItemsPicture = width * 0.80;
    double transform = (1 - scale).clamp(0, 1);
    return Container(
      width: width,
      margin: const EdgeInsets.only(left: kPadding * 2),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
                height: height - 10,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: itemsList[i].background,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: itemsList[i].background.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(15, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 10, left: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemsList[i].title,
                            style: TextStyle(
                                letterSpacing: 1.5,
                                overflow: TextOverflow.ellipsis,
                                color: itemsList[i].textTitleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Roboto'),
                          ),
                          const SizedBox(height: 5),
                          Text('\$${itemsList[i].price.toString()}',
                              style: TextStyle(
                                  color: itemsList[i].textPriceColor,
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
                      transform: Matrix4.identity()
                        ..scale(transform, transform),
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
class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.arrow_left, color: kPrimaryColor)),
          Expanded(
            child: Container(),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.search, color: kPrimaryColor))
        ],
      ),
    );
  }
}
