import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_shop/data/constants.dart';
import 'package:sport_shop/models/items_model.dart';
import 'package:sport_shop/models/sizebtn_model.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.item}) : super(key: key);

  ItemsModel item;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizeItem = size.height * 0.3;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.35,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: size.height * 0.28,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                    color: widget.item.background,
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
                      child: const _AppBar(),
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
                    _Title(items: widget.item),
                    const SizedBox(height: 15),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Text(widget.item.description,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Expanded(child: Container()),
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
                    const SizedBox(height: 20),
                    const Text('Selected Quantity'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _QtyButton(text: '1', tagSizeBtn: 1),
                        _QtyButton(text: '2', tagSizeBtn: 2),
                        _QtyButton(text: '5', tagSizeBtn: 3),
                        _QtyButton(text: '10', tagSizeBtn: 4),
                        _QtyButton(text: 'Custom', tagSizeBtn: 5),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: Colors.black,
                              backgroundColor: kPrimaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 1.1 * kPadding)),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {}),
                    )
                  ],
                )),
          ),
        ],
      ),
    ));
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    Key? key,
    required this.text,
    required this.tagSizeBtn,
  }) : super(key: key);

  final String text;
  final int tagSizeBtn;

  @override
  Widget build(BuildContext context) {
    int i = Provider.of<SizeButtonModel>(context).number;
    return SizedBox(
      height: 50,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            side: tagSizeBtn == i
                ? const BorderSide(width: 1.5, color: kPrimaryColor)
                : const BorderSide(width: 1.0, color: Colors.grey),
            primary: Colors.black,
            backgroundColor: Colors.white,
            //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: tagSizeBtn == i ? kPrimaryColor : Colors.grey,
                fontSize: 17,
                fontWeight:
                    tagSizeBtn == i ? FontWeight.bold : FontWeight.normal),
          ),
          onPressed: () {
            Provider.of<SizeButtonModel>(context, listen: false).number =
                tagSizeBtn;
          }),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.items,
  }) : super(key: key);

  final ItemsModel items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Text(items.title,
              maxLines: 3,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis),
        ),
        Flexible(
          child: Text('\$${items.price.toString()}',
              style: Theme.of(context).textTheme.headline5),
        )
      ],
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white)),
          Expanded(
            child: Container(),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.heart,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
