import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reem_flora/constants/constants.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.product});
  final product;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int quantity = 0;
  double totalPrice = 0.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Details",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: size.width > 500
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 400,
                    width: size.width / 3.0,
                    child: Hero(
                      tag: widget.product.variantBarcode,
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: CachedNetworkImage(
                          width: double.infinity,
                          placeholder: (context, _) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageUrl: widget.product.imageSrc,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: size.width / 1.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: ColoredBox(
                                        color: Constants.primaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.product.handle,
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: ColoredBox(
                                        color: Constants.primaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.product.tags,
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontSize,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Description:",
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      widget.product.handle,
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .fontSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Price:",
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      r'$ ' + widget.product.variantPrice,
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .fontSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Available Qty:",
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      widget.product.variantInventoryQty +
                                          r' Pcs',
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .fontSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 50.0,
                              ),
                              QrImage(
                                data: widget.product.variantBarcode,
                                version: QrVersions.min,
                                size: size.width > 500 ? 200 : 150,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50.0,
                              ),
                              SizedBox(
                                width: 210,
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        20.0,
                                      ),
                                    ),
                                  ),
                                  elevation: 20.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 80.0,
                                          width: 80.0,
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              width: double.infinity,
                                              placeholder: (context, _) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              imageUrl: widget.product.imageSrc,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.product.title,
                                          style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .fontSize,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Qty:",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .fontSize,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                  color: Constants.primaryColor,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  right: 12.0,
                                                  top: 6.0,
                                                  bottom: 6.0,
                                                ),
                                                child: AnimatedSwitcher(
                                                  transitionBuilder:
                                                      (child, animation) =>
                                                          FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  ),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  child: Text(
                                                    quantity.toString(),
                                                    key: ValueKey(quantity),
                                                    style: TextStyle(
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontSize,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                onTap: () {
                                                  if (quantity != 0) {
                                                    setState(() {
                                                      quantity--;
                                                      totalPrice = totalPrice -
                                                          double.parse(widget
                                                              .product
                                                              .variantPrice);
                                                    });
                                                  } else {
                                                    null;
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color: Constants
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                    if (totalPrice == 0.0) {
                                                      totalPrice = double.parse(
                                                          widget.product
                                                              .variantPrice);
                                                    } else {
                                                      totalPrice = totalPrice +
                                                          double.parse(widget
                                                              .product
                                                              .variantPrice);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color: Constants
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedCrossFade(
                                    secondCurve: Curves.ease,
                                    firstCurve: Curves.ease,
                                    reverseDuration:
                                        const Duration(milliseconds: 300),
                                    duration: const Duration(milliseconds: 300),
                                    crossFadeState: totalPrice != 0.0
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    secondChild: const SizedBox(
                                      height: 21,
                                    ),
                                    firstChild: AnimatedSwitcher(
                                      transitionBuilder: (child, animation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                      reverseDuration:
                                          const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Text(
                                        r"$ Total price: " +
                                            totalPrice.toString(),
                                        key: ValueKey(
                                          totalPrice.toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MaterialButton(
                                      color: Constants.primaryColor,
                                      elevation: 10.0,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          "Checkout",
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .fontSize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      // color: Constants.primaryColor,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: widget.product.handle,
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: CachedNetworkImage(
                          width: double.infinity,
                          placeholder: (context, _) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageUrl: widget.product.imageSrc,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: ColoredBox(
                                    color: Constants.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.product.handle,
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: ColoredBox(
                                    color: Constants.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.product.tags,
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Description:",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  widget.product.handle,
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .fontSize,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Price:",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  r'$ ' + widget.product.variantPrice,
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .fontSize,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Available Qty:",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  widget.product.variantInventoryQty + r' Pcs',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .fontSize,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 210,
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              20.0,
                                            ),
                                          ),
                                        ),
                                        elevation: 20.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 80.0,
                                                width: 80.0,
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    width: double.infinity,
                                                    placeholder: (context, _) =>
                                                        const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    imageUrl:
                                                        widget.product.imageSrc,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                widget.product.title,
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .fontSize,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "Qty:",
                                                    style: TextStyle(
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .fontSize,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                        color: Constants
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 12.0,
                                                        right: 12.0,
                                                        top: 6.0,
                                                        bottom: 6.0,
                                                      ),
                                                      child: AnimatedSwitcher(
                                                        transitionBuilder:
                                                            (child, animation) =>
                                                                FadeTransition(
                                                          opacity: animation,
                                                          child: child,
                                                        ),
                                                        reverseDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        child: Text(
                                                          quantity.toString(),
                                                          key: ValueKey(
                                                              quantity),
                                                          style: TextStyle(
                                                            fontSize: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .fontSize,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      onTap: () {
                                                        if (quantity != 0) {
                                                          setState(() {
                                                            quantity--;
                                                            totalPrice = totalPrice -
                                                                double.parse(widget
                                                                    .product
                                                                    .variantPrice);
                                                          });
                                                        } else {
                                                          null;
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: Constants
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      onTap: () {
                                                        setState(() {
                                                          quantity++;
                                                          if (totalPrice ==
                                                              0.0) {
                                                            totalPrice = double
                                                                .parse(widget
                                                                    .product
                                                                    .variantPrice);
                                                          } else {
                                                            totalPrice = totalPrice +
                                                                double.parse(widget
                                                                    .product
                                                                    .variantPrice);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: Constants
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    QrImage(
                                      data: widget.product.variantBarcode,
                                      version: QrVersions.min,
                                      size: size.width > 500 ? 200 : 150,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedCrossFade(
                                      secondCurve: Curves.ease,
                                      firstCurve: Curves.ease,
                                      reverseDuration:
                                          const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      crossFadeState: totalPrice != 0.0
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      secondChild: const SizedBox(
                                        height: 21,
                                      ),
                                      firstChild: AnimatedSwitcher(
                                        transitionBuilder: (child, animation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                        reverseDuration:
                                            const Duration(milliseconds: 300),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Text(
                                          r"$ Total price: " +
                                              totalPrice.toString(),
                                          key: ValueKey(
                                            totalPrice.toString(),
                                          ),
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .fontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(
                                        color: Constants.primaryColor,
                                        elevation: 10.0,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            "Checkout",
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontSize,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        // color: Constants.primaryColor,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
