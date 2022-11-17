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

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 600,
    ),
  );
  late final Animation<double> animationX =
      Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );
  List<bool> hoveringListOfGrid = [];

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

  final List<ProductModel> favoriteProducts = [];
  ScrollController gridViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder<Box<Cart>>(
        valueListenable: Boxes.getAllCartPro().listenable(),
        builder: (context, box, child) {
          final cartItems = box.values.toList().cast<Cart>();
          return ValueListenableBuilder<Box<ProductModel>>(
            valueListenable: Boxes.getAllFavPro().listenable(),
            builder: (context, box, _) {
              final favProducts = box.values.toList().cast<ProductModel>();
              hoveringListOfGrid.length = favProducts.length;
              if (favProducts.isEmpty) {
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
                      "No favorite items found",
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
                          itemCount: favProducts.length,
                          itemBuilder: (context, index) {
                            return itemsForGridView(index, context, size,
                                favProducts, cartItems, hoveringListOfGrid);
                          }),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget itemsForGridView(
      int index,
      BuildContext context,
      Size size,
      List<ProductModel> favoList,
      List<Cart> cartList,
      List<bool> hoveringListOfGrid) {
    final box = Boxes.getAllFavPro();
    final boxOfCart = Boxes.getAllCartPro();
    return Hero(
      tag: favoList[index].variantBarcode,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
                  product: favoList[index],
                ),
                type: PageTransitionType.fade,
              ),
            );
          },
          onHover: (value) {
            setState(() {
              hoveringListOfGrid[index] = !hoveringListOfGrid[index];
            });
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
                    child: InkWell(
                      hoverColor: Constants.blackColor,
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () {
                        if (box.containsKey(favoList[index].handle)) {
                          FavoritreProvider().removeFromFavorite(
                              favoList[index], (favoList[index].handle));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text("Item removed from favorites"),
                              duration: const Duration(seconds: 1),
                              elevation: 10.0,
                              behavior: SnackBarBehavior.floating,
                              width: size.width / 2,
                            ),
                          );
                        } else {
                          FavoritreProvider().addToFavorite(
                            favoList[index],
                            favoList[index].handle,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Item added to favorites"),
                              behavior: SnackBarBehavior.floating,
                              width: size.width / 2,
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          box.containsKey(favoList[index].handle)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Constants.primaryColor,
                          size: 19.0,
                        ),
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
                        favoList[index].handle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      favoList[index].tags.isNotEmpty
                          ? Text(
                              favoList[index].tags,
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
                                r'$ ' + favoList[index].variantPrice,
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
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                boxOfCart.containsKey(favoList[index].handle)
                                    ? Icons.shopping_cart
                                    : Icons.shopping_cart_outlined,
                                color: Constants.primaryColor,
                                size: 19.0,
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
                  imageUrl: favoList[index].imageSrc,
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
