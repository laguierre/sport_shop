import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/constants.dart';
import '../../models/items_model.dart';
import '../../models/sizebtn_model.dart';

class AddCartButton extends StatelessWidget {
  const AddCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8.0),
                ),
                primary: Colors.black,
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 1.1 * kPadding)),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {}),
      ),
    );
  }
}

class SelectedQuantityButton extends StatelessWidget {
  const SelectedQuantityButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FadeInLeft(
            duration: const Duration(milliseconds: 900),
            child:
            const _QtyButton(text: '1', tagSizeBtn: 1)),
        FadeInLeft(
            duration: const Duration(milliseconds: 800),
            child:
            const _QtyButton(text: '2', tagSizeBtn: 2)),
        FadeInLeft(
            duration: const Duration(milliseconds: 700),
            child:
            const _QtyButton(text: '5', tagSizeBtn: 3)),
        FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child:
            const _QtyButton(text: '10', tagSizeBtn: 4)),
        FadeInLeft(
            duration: const Duration(milliseconds: 300),
            child: const _QtyButton(
                text: 'Custom', tagSizeBtn: 5)),
      ],
    );
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
class MyTitle extends StatelessWidget {
  const MyTitle({
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

class MyAppBarDetails extends StatelessWidget {
  const MyAppBarDetails({
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