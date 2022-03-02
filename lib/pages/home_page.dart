import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sport_shop/models/items_model.dart';
import 'package:sport_shop/pages/details_page.dart';
import '../data/constants.dart';
import '../data/items_data.dart';
import '../models/topbtn_model.dart';
import 'home_page/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(listenScrolling);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listenScrolling() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int number = Provider.of<TopButtonModel>(context).number;
    double heightCard = size.height * 0.4;
    double widthCard = size.width * 0.7;
    final itemsList = ItemsList;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AppBar(),
          const SizedBox(height: 15),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 2 * kPadding),
              child:
                  Text('Items', style: Theme.of(context).textTheme.headline1)),
          const SizedBox(height: 15),
          _TopButtons(number: number),
          const SizedBox(height: 30),
          _ItemList(
              heightCard: heightCard,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemsList: itemsList,
              widthCard: widthCard),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 2 * kPadding),
            child:
                Text('Popular', style: Theme.of(context).textTheme.bodyText2),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: 3 * kPadding, vertical: kPadding),
              itemCount: itemsList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  child: PopularCard(itemsList: itemsList, i: i),
                  onTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int i) {
                return const Divider(thickness: 1.5);
              },
            ),
          )
        ],
      ),
    ));
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    Key? key,
    required this.heightCard,
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.itemsList,
    required this.widthCard,
  }) : super(key: key);

  final double heightCard;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final List<ItemsModel> itemsList;
  final double widthCard;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    double scaleFirst = 0;
    double scaleLast = 0;
    return SizedBox(
      height: heightCard,
      width: double.infinity,
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemsList.length,
        itemBuilder: (BuildContext context, int i) {
          //print(itemPositionsListener.itemPositions.value);
          if (itemPositionsListener.itemPositions.value.isNotEmpty) {
            double total = (itemPositionsListener
                        .itemPositions.value.first.itemLeadingEdge -
                    itemPositionsListener
                        .itemPositions.value.last.itemTrailingEdge)
                .abs();

            if (itemPositionsListener
                        .itemPositions.value.last.itemLeadingEdge >
                    total * 0.2 &&
                itemPositionsListener
                        .itemPositions.value.last.itemTrailingEdge <
                    total * 0.8) {
              index = itemPositionsListener.itemPositions.value.last.index;
              scaleLast = (itemPositionsListener
                          .itemPositions.value.last.itemLeadingEdge *
                      1)
                  .clamp(0, 1);
            } else {
              index = itemPositionsListener.itemPositions.value.first.index;
              scaleFirst = (itemPositionsListener
                          .itemPositions.value.first.itemTrailingEdge *
                      1.75)
                  .clamp(0, 1);
            }

            index = itemPositionsListener.itemPositions.value.first.index;
            scaleFirst = (itemPositionsListener
                .itemPositions.value.first.itemTrailingEdge *
                1.75)
                .clamp(0, 1);


            //print(itemPositionsListener.itemPositions.value.first);
            //print(itemPositionsListener.itemPositions.value.last);
          }

          return ValueListenableBuilder(
            valueListenable: itemPositionsListener.itemPositions,
            builder: (BuildContext context, positions, Widget? child) {
              return ItemCard(
                  itemsList: itemsList,
                  i: i,
                  scale: i != index ? scaleLast : 1 - scaleFirst,
                  width: widthCard,
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, _) {
                          return FadeTransition(
                              opacity: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut)),
                              child: DetailsPage(
                                item: itemsList[i],
                              ));
                        }));
                  });
            },
          );
        },
      ),
    );
  }
}

class _TopButtons extends StatelessWidget {
  const _TopButtons({
    Key? key,
    required this.number,
  }) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kPadding),
      height: 38,
      child: ListView.separated(
        itemCount: btnNamesText.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: kPadding),
        itemBuilder: (BuildContext context, int i) {
          return OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  primary: Colors.black,
                  backgroundColor: number == i ? kPrimaryColor : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 25)),
              child: Text(
                btnNamesText[i],
                style: TextStyle(
                    color: number == i ? Colors.white : Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Provider.of<TopButtonModel>(context, listen: false).number = i;
              });
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
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
              icon: Icon(CupertinoIcons.arrow_left, color: kPrimaryColor)),
          Expanded(
            child: Container(),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.search, color: kPrimaryColor))
        ],
      ),
    );
  }
}
