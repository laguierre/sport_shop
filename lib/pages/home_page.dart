import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
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
  final _pageController =
      PageController(viewportFraction: 0.83, initialPage: 0);
  double currentPage = 0;
  final itemsList = ItemsList;
  bool flagInit = false;

  @override
  void initState() {
    _pageController.addListener(listenerPage);
    _initializeColor();
    super.initState();
  }

  Future _initializeColor() async {
    for (int i = 0; i < itemsList.length; i++) {
      PaletteGenerator colors = await PaletteGenerator.fromImageProvider(
          AssetImage(itemsList[i].images));
      itemsList[i].background = colors.dominantColor!.color.withOpacity(0.8);
      itemsList[i].textTitleColor = colors.dominantColor!.bodyTextColor;
      itemsList[i].textPriceColor = colors.dominantColor!.titleTextColor;
    }

    setState(() {
      flagInit = true;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(listenerPage);
    _pageController.dispose();
    super.dispose();
  }

  void listenerPage() {
    setState(() {
      currentPage = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int number = Provider.of<TopButtonModel>(context).number;
    double heightCard = size.height * 0.42;
    double widthCard = size.width * 0.7;

    if (!flagInit) {
      return const MyCircularProgress();
    }
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyAppBar(),
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
            itemsList: itemsList,
            widthCard: widthCard,
            pageController: _pageController,
            currentPage: currentPage,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 2 * kPadding),
            child:
                Text('Popular', style: Theme.of(context).textTheme.bodyText2),
          ),
          const SizedBox(height: 15),
          _PopularList(itemsList: itemsList)
        ],
      ),
    ));
  }
}

class MyCircularProgress extends StatelessWidget {
  const MyCircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _PopularList extends StatelessWidget {
  const _PopularList({
    Key? key,
    required this.itemsList,
  }) : super(key: key);

  final List<ItemsModel> itemsList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
            horizontal: 3 * kPadding, vertical: kPadding),
        itemCount: itemsList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            child: PopularCard(itemsList: itemsList, i: i),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, _) {
                    return FadeTransition(
                        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animation, curve: Curves.easeOut)),
                        child: DetailsPage(
                          item: itemsList[i],
                        ));
                  }));
            },
          );
        },
        separatorBuilder: (BuildContext context, int i) {
          return const Divider(thickness: 1.5);
        },
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    Key? key,
    required this.heightCard,
    required this.itemsList,
    required this.widthCard,
    required this.pageController,
    required this.currentPage,
  }) : super(key: key);

  final double heightCard;

  final List<ItemsModel> itemsList;
  final double widthCard;
  final PageController pageController;
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightCard,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemsList.length,
        itemBuilder: (BuildContext context, int i) {
          final result = currentPage - i;
          double value = (-1 * result * result + 1).clamp(0, 1);
          return ItemCard(
              itemsList: itemsList,
              i: i,
              scale: i != result ? 1 - value : 0,
              width: widthCard,
              height: heightCard,
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, _) {
                      return FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animation, curve: Curves.easeOut)),
                          child: DetailsPage(
                            item: itemsList[i],
                          ));
                    }));
              });
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
