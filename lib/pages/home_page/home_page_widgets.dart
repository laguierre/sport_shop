import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../data/constants.dart';
import '../../data/items_data.dart';
import '../../models/brand_model.dart';
import '../../models/items_model.dart';
import '../../models/topbtn_model.dart';

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
                width: sizeItemsPicture,
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
                bottom: height * 0.07,
                right: width / 2 - sizeItemsPicture / 2,
                child: Hero(
                    tag: itemsList[i].images + "1",
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
    var size = MediaQuery.of(context).size;
    double sizePopularItems = size.height * 0.095;
    return Row(
      children: [
        SizedBox(
          width: sizePopularItems,
          height: sizePopularItems,
          child: Hero(
              tag: itemsList[i].images + "2",
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
              icon:
                  const Icon(CupertinoIcons.arrow_left, color: kPrimaryColor)),
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

// ignore: must_be_immutable
class TopButtons extends StatelessWidget {
  TopButtons({
    Key? key,
    required this.number,
    required this.pageController,
  }) : super(key: key);

  final int number;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    var itemsList = ItemsList;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kPadding),
      height: 38,
      child: ListView.separated(
        itemCount: btnNamesText.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: kPadding),
        itemBuilder: (BuildContext context, int i) {
          return FadeInLeft(
            duration: Duration(milliseconds: 100 * (btnNamesText.length - i)),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: number == i
                        ? const BorderSide(width: 1.5, color: kPrimaryColor)
                        : const BorderSide(width: 1.5, color: Colors.grey),
                    shadowColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    primary: Colors.black,
                    backgroundColor:
                        number == i ? kPrimaryColor : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 25)),
                child: Text(
                  btnNamesText[i],
                  style: TextStyle(
                      color: number == i ? Colors.white : Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Provider.of<TopButtonModel>(context, listen: false).number =
                      i;
                  if (i != 0) {
                    Provider.of<BrandFilterModel>(context, listen: false)
                            .filteredList =
                        itemsList
                            .where((element) =>
                                element.brand.contains(btnNamesText[i]))
                            .toList();
                  } else {
                    Provider.of<BrandFilterModel>(context, listen: false)
                        .filteredList = itemsList;
                  }
                  Provider.of<BrandFilterModel>(context, listen: false)
                      .currentPage = 0;
                  pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.decelerate);
                }),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }
}

///Circular Progress Bar when BackGround Colors is calculated///
class MyCircularProgress extends StatelessWidget {
  const MyCircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Positioned(
                    bottom: 40,
                      child:
                          Text("Loading...", style: TextStyle(fontSize: 20))),
                  Lottie.asset("lib/assets/gifs/sports-loader.json",
                      fit: BoxFit.contain, repeat: true),
                ],
              ),
            ),
            //const Text("Loading...", style: TextStyle(fontSize: 20)),

            //const CircularProgressIndicator(color: kPrimaryColor),
          ],
        ),
      ),
    );
  }
}
