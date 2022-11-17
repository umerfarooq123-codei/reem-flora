import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/Boxes/Box.dart';
import 'package:reem_flora/constants/constants.dart';
import 'package:reem_flora/controller/productController.dart';
import 'package:reem_flora/detail/detail.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';
import 'package:reem_flora/provider/favoriteProvider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ProductController productController = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();
  ScrollController gridViewScrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  List<bool> hoveringListOfGrid = List.generate(30, (index) => false);
  List<bool> hoveringListOfHori = List.generate(140, (index) => false);
  bool showBackToTopButton = false;
  bool isFavorite = false;
  double elevation = 0.0;
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 800,
    ),
  );
  late final Animation<double> animationX =
      Tween<double>(begin: -1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );
  late final Animation<double> animationY =
      Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  // scroll controller
  late ScrollController scrollController;
  int selectedIndex = 0;
  @override
  void initState() {
    animationController.forward();
    searchController.addListener(() {
      setState(() {});
    });
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (scrollController.offset >= 200) {
            showBackToTopButton = true; // show the back-to-top button
          } else {
            showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose(); // dispose the controller
    animationController.dispose();
    super.dispose();
  }

  int currnetTabBarItem = 0;
  //Plants category
  List<String> listOfPlantTypes = [
    'All',
    'Popular',
    'Bouquets',
    'Garden',
    'Supplement',
  ];

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder<Box<Cart>>(
      valueListenable: Boxes.getAllCartPro().listenable(),
      builder: (context, value, child) {
        return ValueListenableBuilder<Box<ProductModel>>(
            valueListenable: Boxes.getAllFavPro().listenable(),
            builder: (context, box, _) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                floatingActionButton: showBackToTopButton
                    ? FloatingActionButton(
                        onPressed: scrollToTop,
                        child: const Icon(Icons.arrow_upward),
                      )
                    : null,
                body: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // size.width <= 500.0
                        //     ? AnimatedBuilder(
                        //         animation: animationX,
                        //         builder: (context, child) {
                        //           final y = animationX.value * size.height;
                        //           return Transform(
                        //             transform: Matrix4.translationValues(0, y, 0),
                        //             child: child,
                        //           );
                        //         },
                        //         child: searchTextField(size),
                        //       )
                        //     : Container(),
                        size.width <= 500.0
                            ? AnimatedBuilder(
                                animation: animationX,
                                builder: (context, child) {
                                  final y = animationX.value * size.height;
                                  return Transform(
                                    transform:
                                        Matrix4.translationValues(0, y, 0),
                                    child: child,
                                  );
                                },
                                child: optionsTabBar(listOfPlantTypes, size),
                              )
                            : Container(),
                        size.width > 500.0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: AnimatedBuilder(
                                      animation: animationX,
                                      builder: (context, child) {
                                        final y =
                                            animationX.value * size.height;
                                        return Transform(
                                          transform: Matrix4.translationValues(
                                              0, y, 0),
                                          child: child,
                                        );
                                      },
                                      child: SizedBox(
                                        width: 450.0,
                                        child: optionsTabBar(
                                            listOfPlantTypes, size),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        AnimatedBuilder(
                          animation: animationX,
                          builder: (context, child) {
                            final y = animationX.value * size.height;
                            return Transform(
                              transform: Matrix4.translationValues(0, y, 0),
                              child: child,
                            );
                          },
                          child: SizedBox(
                            height: size.width > 500
                                ? size.height * 0.35
                                : size.height * 0.30,
                            width: size.width,
                            child: horizontalListView(size),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animationY,
                          builder: (context, child) {
                            final y = animationY.value * size.height;
                            return Transform(
                              transform: Matrix4.translationValues(0, y, 0),
                              child: child,
                            );
                          },
                          child: SizedBox(
                            height: 30.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: newPlantsText(),
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animationY,
                          builder: (context, child) {
                            final y = animationY.value * size.height;
                            return Transform(
                              transform: Matrix4.translationValues(0, y, 0),
                              child: child,
                            );
                          },
                          child: SizedBox(
                            height: size.height / 1,
                            width: size.width,
                            child: gridView(size),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget gridView(Size size) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        controller: gridViewScrollController,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > 550.0 ? 5 : 2,
        ),
        scrollDirection: Axis.vertical,
        itemCount: 30,
        itemBuilder: (context, index) {
          return Obx(() {
            if (productController.loading.value) {
              return shimmerForText(200);
            }
            return itemsForGridView(index, context, size);
          });
        });
  }

  Widget itemsForGridView(int index, BuildContext context, Size size) {
    final box = Boxes.getAllFavPro();
    final boxOfCart = Boxes.getAllCartPro();
    return Hero(
      tag: productController.productList[index].variantBarcode,
      child: Material(
        child: InkWell(
          onHover: (value) {
            setState(() {
              hoveringListOfGrid[index] = !hoveringListOfGrid[index];
            });
          },
          hoverColor: Colors.transparent,
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
                  product: productController.productList[index],
                ),
                type: PageTransitionType.fade,
              ),
            );
          },
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
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () {
                        if (box.containsKey(
                            productController.productList[index].handle)) {
                          FavoritreProvider().removeFromFavorite(
                              productController.productList[index],
                              (productController.productList[index].handle));
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content:
                                    const Text("Item removed from favorites"),
                                behavior: SnackBarBehavior.floating,
                                width: size.width / 2,
                              ),
                            );
                        } else {
                          FavoritreProvider().addToFavorite(
                            productController.productList[index],
                            productController.productList[index].handle,
                          );
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
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
                          box.containsKey(
                                  productController.productList[index].handle)
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
                        productController.productList[index].handle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      productController.productList[index].tags.isNotEmpty
                          ? Text(
                              productController.productList[index].tags,
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
                                r'$ ' +
                                    productController
                                        .productList[index].variantPrice,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.share,
                                      color: Constants.primaryColor,
                                      size: 19.0,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {
                                    if (boxOfCart.containsKey(productController
                                        .productList[index].handle)) {
                                      CartProvider().removeFromCart(
                                          productController.cartList[index],
                                          (productController
                                              .productList[index].handle));
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
                                        productController.cartList[index],
                                        productController
                                            .productList[index].handle,
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                "Item added to cart"),
                                            behavior: SnackBarBehavior.floating,
                                            width: size.width / 2,
                                          ),
                                        );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      boxOfCart.containsKey(productController
                                              .cartList[index].handle)
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
                      )
                    ],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CachedNetworkImage(
                  imageUrl: productController.productList[index].imageSrc,
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

  Widget horizontalListView(Size size) {
    return SizedBox(
      height: size.height < 500 ? 200 : 400,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: listViewScrollController,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 140,
          itemBuilder: (context, index) {
            return Obx(() {
              if (productController.loading.value) {
                return shimmerForText(size.width < 500 ? 180 : 200);
              }
              return itemsForHorizontalListView(index, context, size);
            });
          }),
    );
  }

  Widget itemsForHorizontalListView(
      int index, BuildContext context, Size size) {
    final box = Boxes.getAllFavPro();
    final boxOfCart = Boxes.getAllCartPro();
    return Material(
      child: InkWell(
        onHover: (value) {
          setState(() {
            hoveringListOfHori[index] = !hoveringListOfHori[index];
          });
        },
        hoverColor: Colors.transparent,
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
                product: productController.productList[index],
              ),
              type: PageTransitionType.fade,
            ),
          );
        },
        child: Card(
          elevation: hoveringListOfHori[index] ? 15.0 : 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: SizedBox(
            width: size.width < 500 ? 180 : 200,
            child: Column(
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: size.width > 500 ? 4.0 / 2.9 : 5.0 / 3.1,
                      child: CachedNetworkImage(
                        imageUrl:
                            productController.productList[index].imageSrc,
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
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            if (box.containsKey(productController
                                .productList[index].handle)) {
                              FavoritreProvider().removeFromFavorite(
                                  productController.productList[index],
                                  productController
                                      .productList[index].handle);
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        "Item removed from favorites"),
                                    behavior: SnackBarBehavior.floating,
                                    width: size.width / 2,
                                  ),
                                );
                            } else {
                              FavoritreProvider().addToFavorite(
                                productController.productList[index],
                                productController.productList[index].handle,
                              );
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content:
                                        const Text("Item added to favorites"),
                                    behavior: SnackBarBehavior.floating,
                                    width: size.width / 2,
                                  ),
                                );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              box.containsKey(productController
                                      .productList[index].handle)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Constants.primaryColor,
                              size: 19.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Text(
                    productController.productList[index].handle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Text(
                    productController.productList[index].tags,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Price:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            r'$ ' +
                                productController
                                    .productList[index].variantPrice,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20.0),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.share,
                                    color: Constants.primaryColor,
                                    size: 19.0,
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20.0),
                                onTap: () {
                                  if (boxOfCart.containsKey(productController
                                      .productList[index].handle)) {
                                    CartProvider().removeFromCart(
                                        productController.cartList[index],
                                        (productController
                                            .productList[index].handle));
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
                                      productController.cartList[index],
                                      productController
                                          .productList[index].handle,
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              "Item added to cart"),
                                          behavior: SnackBarBehavior.floating,
                                          width: size.width / 2,
                                        ),
                                      );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    boxOfCart.containsKey(productController
                                            .cartList[index].handle)
                                        ? Icons.shopping_cart
                                        : Icons.shopping_cart_outlined,
                                    color: Constants.primaryColor,
                                    size: 19.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget optionsTabBar(List<String> listOfPlantTypes, Size size) {
    return Card(
      elevation: 10,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Align(
          alignment: size.width > 500 ? Alignment.center : Alignment.centerLeft,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 6.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: tophorizontalistItem(listOfPlantTypes[0], 0, 31),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 6.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: tophorizontalistItem(listOfPlantTypes[1], 1, 41),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 6.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: tophorizontalistItem(listOfPlantTypes[2], 2, 51),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 6.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: tophorizontalistItem(listOfPlantTypes[3], 3, 61),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 6.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: tophorizontalistItem(listOfPlantTypes[4], 4, 71),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchTextField(Size size) {
    return Container(
      padding: const EdgeInsets.only(
        // bottom: 8.0,
        left: 8.0,
        right: 8.0,
        // top: 8.0,
      ),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onEditingComplete: () {},
        cursorColor: Colors.black,
        showCursor: true,
        controller: searchController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                )
              : Container(
                  width: 0,
                ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: 'Search',
          labelText: 'Search',
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget tophorizontalistItem(String item, int index, int key) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(
        border: Border.all(
          color: currnetTabBarItem == index
              ? Colors.transparent
              : Constants.primaryColor,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: currnetTabBarItem == index
            ? Constants.primaryColor
            : Colors.transparent,
      ),
      child: InkWell(
        hoverColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          setState(() {
            currnetTabBarItem = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              item,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                color: currnetTabBarItem == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container newPlantsText() {
    return Container(
      padding: const EdgeInsets.only(left: 16, bottom: 4.0, top: 4.0),
      child: Text(
        'Featured',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget shimmerForText(double width) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.6),
      baseColor: Colors.grey.withOpacity(0.25),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 55.0,
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.0,
            ),
          ),
        ),
      ),
    );
  }
}
