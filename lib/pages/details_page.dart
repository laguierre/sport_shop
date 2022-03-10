import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:sport_shop/data/constants.dart';
import 'package:sport_shop/models/items_model.dart';
import 'details_page/details_page_widgets.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  DetailsPage(
      {Key? key,
      required this.item,
      required this.heightCard,
      required this.widthCard})
      : super(key: key);

  ItemsModel item;
  double widthCard;
  double heightCard;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  double scale = 0;
  final singleScrollController = ScrollController();

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizeItem = size.height * 0.3;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * (-0.335 * animation.value + 0.635) +
                40 * animation.value,
            width: double.infinity,
            //color: Colors.black,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 15 * animation.value,
                  child: Transform.translate(
                    offset: Offset(
                        190 * animation.value - 35, -320 * animation.value),
                    child: Transform.rotate(
                      angle: 0.68 * animation.value,
                      child: Transform.scale(
                        scale: 1.5 * animation.value + 1,
                        child: Container(
                          width: widget.widthCard * 0.8,
                          height: widget.heightCard * 1.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10 * animation.value + 20),
                            color: widget.item.background,
                            boxShadow: [
                              BoxShadow(
                                color: widget.item.background.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                    -5, 4), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Hero(
                    tag: widget.item.images,
                    child: SizedBox(
                        width: sizeItem,
                        height: sizeItem,
                        child: Image.asset(widget.item.images)),
                  ),
                ),
                Positioned(
                    top: 0,
                    child: SizedBox(
                      height: 50,
                      width: size.width,
                      child: const MyAppBarDetails(),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2 * kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    MyTitle(items: widget.item),
                    const SizedBox(height: 15),
                    Expanded(
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        gradientFractionOnEnd: 0.5,
                        gradientFractionOnStart: 0.5,
                        child: SingleChildScrollView(
                          controller: singleScrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Text(widget.item.description,
                              style: Theme.of(context).textTheme.headline4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'Size: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                                text: 'N/A',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor)),
                          ]),
                        ),
                        Expanded(child: Container()),
                        const Text(
                          'Sized Guide',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 15),
                            Text('Selected Quantity'),
                            SizedBox(height: 15),
                            SelectedQuantityButton(),
                            SizedBox(height: 20),
                            AddCartButton()
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }
}
