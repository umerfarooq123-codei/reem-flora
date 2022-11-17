import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/Boxes/Box.dart';
import 'package:reem_flora/constants/constants.dart';
import 'package:reem_flora/detail/detail.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';
import 'package:reem_flora/provider/favoriteProvider.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 600,
    ),
  );
  List<bool> hoveringListOfGrid = [];
  late final Animation<double> animationX =
      Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  @override
  void initState() {
    hoveringListOfGrid = List.generate(1000, (index) => false);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  final List<Cart> favoriteProducts = [];
  ScrollController gridViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder<Box<ProductModel>>(
          valueListenable: Boxes.getAllFavPro().listenable(),
          builder: (context, box, child) {
            final favItems = box.values.toList().cast<ProductModel>();
            return ValueListenableBuilder<Box<Cart>>(
              valueListenable: Boxes.getAllCartPro().listenable(),
              builder: (context, box, _) {
                final cartItems = box.values.toList().cast<Cart>();
                hoveringListOfGrid.length = cartItems.length;
                if (cartItems.isEmpty) {
                  return AnimatedBuilder(
                    animation: animationX,
                    builder: (context, child) {
                      final y = animationX.value * size.height;
                      return Transform(
                        transform: Matrix4.translationValues(0, y, 0),
                        child: child,
                      );
                    },
                    child: const Center(
                      child: Text(
                        "Cart is empty",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedBuilder(
                        animation: animationX,
                        builder: (context, child) {
                          final y = animationX.value * size.height;
                          return Transform(
                            transform: Matrix4.translationValues(0, y, 0),
                            child: child,
                          );
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          controller: gridViewScrollController,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.width > 550.0 ? 5 : 2,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) => itemsForGridView(
                              index, context, size, cartItems, favItems),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }

  Widget itemsForGridView(int index, BuildContext context, Size size,
      List<Cart> cartList, List favoList) {
    final box = Boxes.getAllCartPro();
    final boxOfFavo = Boxes.getAllFavPro();
    return Hero(
      tag: cartList[index].variantBarcode,
      child: Material(
        child: InkWell(
          onHover: (value) {
            setState(() {
              hoveringListOfGrid[index] = !hoveringListOfGrid[index];
            });
          },
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(
                  milliseconds: 300,
                ),
                reverseDuration: const Duration(
                  milliseconds: 300,
                ),
                child: Detail(
                  product: cartList[index],
                ),
                type: PageTransitionType.fade,
              ),
            );
          },
          hoverColor: Colors.transparent,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            elevation: hoveringListOfGrid[index] ? 15.0 : 0.0,
            child: GridTile(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        boxOfFavo.isNotEmpty
                            ? boxOfFavo.containsKey(cartList[index].handle)
                                ? Icons.favorite
                                : Icons.favorite_outline
                            : Icons.favorite_outline,
                        color: Constants.primaryColor,
                        size: 19.0,
                      ),
                    ),
                  ),
                ],
              ),
              footer: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      10.0,
                    ),
                    bottomRight: Radius.circular(
                      10.0,
                    ),
                  ),
                  color: Colors.black38,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartList[index].handle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      cartList[index].tags.isNotEmpty
                          ? Text(
                              cartList[index].tags,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Price: ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                r'$ ' + cartList[index].variantPrice,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              hoverColor: Constants.blackColor,
                              onTap: () {
                                if (box.containsKey(cartList[index].handle)) {
                                  CartProvider().removeFromCart(cartList[index],
                                      (cartList[index].handle));
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            "Item removed from cart"),
                                        behavior: SnackBarBehavior.floating,
                                        width: size.width / 2,
                                      ),
                                    );
                                } else {
                                  CartProvider().addToCart(
                                    cartList[index],
                                    cartList[index].handle,
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text("Item added to cart"),
                                        behavior: SnackBarBehavior.floating,
                                        width: size.width / 2,
                                      ),
                                    );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  box.containsKey(cartList[index].handle)
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: Constants.primaryColor,
                                  size: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CachedNetworkImage(
                  imageUrl: cartList[index].imageSrc,
                  progressIndicatorBuilder: (context, url, _) => Center(
                    child: SpinKitCircle(
                      size: 30,
                      color: Constants.blackColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
