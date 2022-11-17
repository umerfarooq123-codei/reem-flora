import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/Boxes/Box.dart';
import 'package:reem_flora/cart/cart_items.dart';
import 'package:reem_flora/constants/constants.dart';
import 'package:reem_flora/controller/productController.dart';
import 'package:reem_flora/detail/detail.dart';
import 'package:reem_flora/favorite/favorite_items.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';
import 'package:reem_flora/profile/profile.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../homePage/homePage.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  String searchedQuery = "";
  TextEditingController searchController = TextEditingController();
  ScrollController gridViewScrollController = ScrollController();
  final ProductController productController = Get.put(ProductController());
  bool isSearchFieldVisible = false;
  List<IconData> iconsList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1000,
    ),
  );
  List listOfSearchedQuery = [];
  late final Animation<double> animationX =
      Tween<double>(begin: -1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  late final Animation<double> animationY =
      Tween<double>(begin: -1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );
  late final Animation<double> animationY2 =
      Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  List<NavigationRailDestination> railList = [
    const NavigationRailDestination(
      icon: Icon(
        Icons.home,
      ),
      label: Text('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.favorite,
      ),
      label: Text('Favorite'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.shopping_cart,
      ),
      label: Text('Orders'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.person,
      ),
      label: Text('Profile'),
    ),
  ];

  List<BottomNavigationBarItem> bottomNavItemsList = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
      ),
      label: 'Orders',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Profile',
    ),
  ];

  List<String> titles = [
    "Home",
    "Favorite",
    "Orders",
    "Profile",
  ];

  List<Widget> pages = [
    const HomePage(),
    const Favorite(),
    const CartItems(),
    const Profile(),
  ];

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future httpRequest() async {
    var client = http.Client();
    var url = Uri.parse("https://6979-171-50-214-224.ngrok.io/flowers?page=1");
    var response = await client.get(url);
    var json = response.body;
    var result = productModelFromJson(json);
    print(result[0]);
    if (response.statusCode == 200) {
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    animationController.forward();
    searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size constraints = MediaQuery.of(context).size;
    return Obx(() {
      if (productController.isError.value) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Lottie.asset(
                    height: 500.0,
                    'assets/images/internalservererror.json',
                  ),
                  Text(productController.errorString.value)
                ],
              ),
            ),
          ),
        );
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ValueListenableBuilder<Box<Cart>>(
          valueListenable: Boxes.getAllCartPro().listenable(),
          builder: (context, value, child) {
            final cartProducts = value.values.toList().cast<Cart>();
            return ValueListenableBuilder<Box<ProductModel>>(
                valueListenable: Boxes.getAllFavPro().listenable(),
                builder: (context, box, _) {
                  final favProducts = box.values.toList().cast<ProductModel>();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: animationY,
                        builder: (context, child) {
                          final y = animationY.value * constraints.height;
                          return Transform(
                            transform: Matrix4.translationValues(0, y, 0),
                            child: child,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(35.0),
                              bottomRight: Radius.circular(35.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SafeArea(
                              child: constraints.width < 500
                                  ? AnimatedCrossFade(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      crossFadeState: isSearchFieldVisible
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      secondChild: searchTextField(constraints,
                                          favProducts, cartProducts),
                                      firstChild: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                titles[currentIndex],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .fontSize,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        isSearchFieldVisible =
                                                            !isSearchFieldVisible;
                                                      });
                                                    },
                                                    child: ClipOval(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        color: Colors.white,
                                                        child: Icon(
                                                          Icons.search,
                                                          color: Constants
                                                              .blackColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  currentIndex == 1
                                                      ? favProducts.isNotEmpty
                                                          ? InkWell(
                                                              onTap: () {
                                                                final box = Boxes
                                                                    .getAllFavPro();
                                                                box.clear();
                                                              },
                                                              child: ClipOval(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          6.0),
                                                                  color: Colors
                                                                      .white,
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_forever,
                                                                    color: Constants
                                                                        .blackColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container()
                                                      : Container(),
                                                ],
                                              )
                                            ],
                                          )),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            titles[currentIndex],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        AnimatedCrossFade(
                                          firstChild: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    isSearchFieldVisible =
                                                        !isSearchFieldVisible;
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Icon(
                                                        Icons.search,
                                                        color: Constants
                                                            .blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              currentIndex == 1
                                                  ? favProducts.isNotEmpty
                                                      ? InkWell(
                                                          onTap: () {
                                                            final box = Boxes
                                                                .getAllFavPro();
                                                            box.clear();
                                                          },
                                                          child: ClipOval(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              color:
                                                                  Colors.white,
                                                              child: Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color: Constants
                                                                    .blackColor,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container()
                                                  : Container(),
                                            ],
                                          ),
                                          secondChild: searchTextField(
                                              constraints,
                                              favProducts,
                                              cartProducts),
                                          crossFadeState: isSearchFieldVisible
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          reverseDuration: const Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            constraints.width > 500
                                ? SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: SizedBox(
                                      height: 300,
                                      width: 70.0,
                                      child: AnimatedBuilder(
                                        animation: animationX,
                                        builder: (context, child) {
                                          final x = animationX.value *
                                              constraints.width;
                                          return Transform(
                                            transform:
                                                Matrix4.translationValues(
                                                    x, 0, 0),
                                            child: child,
                                          );
                                        },
                                        child: NavigationRail(
                                          labelType:
                                              NavigationRailLabelType.selected,
                                          selectedIconTheme: IconThemeData(
                                              color: Constants.primaryColor),
                                          selectedLabelTextStyle: TextStyle(
                                              color: Constants.primaryColor),
                                          unselectedIconTheme:
                                              const IconThemeData(
                                                  color: Colors.grey),
                                          unselectedLabelTextStyle:
                                              const TextStyle(
                                                  color: Colors.grey),
                                          onDestinationSelected: (value) {
                                            setState(() {
                                              searchController.clear();
                                              isSearchFieldVisible = false;
                                              currentIndex = value;
                                            });
                                          },
                                          destinations: railList,
                                          selectedIndex: currentIndex,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            Expanded(
                              child: AnimatedSwitcher(
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                                reverseDuration:
                                    const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: searchController.text.isNotEmpty &&
                                        listOfSearchedQuery.isEmpty
                                    ? const Expanded(
                                        child: Center(
                                          child: Text(
                                            "No results found",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    : searchController.text.isEmpty
                                        ? pages[currentIndex]
                                        : gridView(constraints),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                });
          },
        ),
        bottomNavigationBar: constraints.width <= 500
            ? AnimatedBuilder(
                animation: animationY2,
                builder: (context, child) {
                  final y = animationY2.value * constraints.height;
                  return Transform(
                    transform: Matrix4.translationValues(0, y, 0),
                    child: child,
                  );
                },
                child: BottomNavigationBar(
                  selectedItemColor: Constants.primaryColor,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  selectedLabelStyle: TextStyle(color: Constants.primaryColor),
                  selectedIconTheme:
                      IconThemeData(color: Constants.primaryColor),
                  unselectedLabelStyle: const TextStyle(color: Colors.grey),
                  unselectedIconTheme: const IconThemeData(color: Colors.grey),
                  onTap: (value) {
                    setState(() {
                      currentIndex = value;
                      isSearchFieldVisible = false;
                      searchController.clear();
                    });
                  },
                  backgroundColor: Colors.white,
                  currentIndex: currentIndex,
                  items: bottomNavItemsList,
                ),
              )
            : null,
      );
    });
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
        itemCount: listOfSearchedQuery.isEmpty
            ? productController.productList.length
            : listOfSearchedQuery.length,
        itemBuilder: (context, index) {
          return itemsForGridView(index, context, size);
        });
  }

  Widget itemsForGridView(int index, BuildContext context, Size size) {
    final box = Boxes.getAllFavPro();
    final boxOfCart = Boxes.getAllCartPro();
    return Hero(
      tag: listOfSearchedQuery.isEmpty
          ? productController.productList[index].handle
          : listOfSearchedQuery[index].handle,
      child: Material(
        child: InkWell(
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
                  product: listOfSearchedQuery.isEmpty
                      ? productController.productList[index]
                      : listOfSearchedQuery[index],
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
            elevation: 10.0,
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
                        box.containsKey(listOfSearchedQuery[index].handle)
                            ? Icons.favorite
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
                        listOfSearchedQuery.isEmpty
                            ? productController.productList[index].handle
                            : listOfSearchedQuery[index].handle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      productController.productList[index].tags.isNotEmpty
                          ? Text(
                              listOfSearchedQuery.isEmpty
                                  ? productController.productList[index].tags
                                  : listOfSearchedQuery[index].tags,
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
                                    (listOfSearchedQuery.isEmpty
                                        ? productController
                                            .productList[index].variantPrice
                                        : listOfSearchedQuery[index]
                                            .variantPrice),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.share,
                                    color: Constants.primaryColor,
                                    size: 19.0,
                                  ),
                                ),
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    boxOfCart.containsKey(
                                            listOfSearchedQuery[index].handle)
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
                      )
                    ],
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CachedNetworkImage(
                  imageUrl: listOfSearchedQuery.isEmpty
                      ? productController.productList[index].imageSrc
                      : listOfSearchedQuery[index].imageSrc,
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

  Widget searchTextField(
    Size constraints,
    List listOfFav,
    List listOfCart,
  ) {
    var textField = TextField(
      onChanged: (String value) {
        onQueryChange(value, listOfFav, listOfCart);
      },
      cursorColor: Colors.white,
      showCursor: true,
      controller: searchController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        suffixIcon: IconButton(
          splashRadius: 20.0,
          onPressed: () {
            if (searchController.text.isNotEmpty) {
              searchController.clear();
            } else {
              setState(() {
                isSearchFieldVisible = !isSearchFieldVisible;
              });
            }
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        hintText: 'Search',
        labelText: 'Search',
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.only(
        // bottom: 8.0,
        left: 8.0,
        right: 8.0,
        top: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: constraints.width > 500 ? 600.0 : double.infinity,
      child: textField,
    );
  }

  onQueryChange(
    String value,
    List listOfFav,
    List listOfCart,
  ) {
    setState(() {
      if (currentIndex == 0) {
        listOfSearchedQuery = productController.productList.where((element) {
          if (element.handle
              .trim()
              .toLowerCase()
              .replaceAll(" ", "")
              .contains(value.trim().toLowerCase().replaceAll(" ", ""))) {
            return element.handle
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          } else if (element.title
              .trim()
              .toLowerCase()
              .replaceAll(" ", "")
              .contains(value.trim().toLowerCase().replaceAll(" ", ""))) {
            return element.title
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          } else {
            return element.tags
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          }
        }).toList();
      } else if (currentIndex == 1) {
        listOfSearchedQuery = listOfFav.where((element) {
          if (element.handle
              .trim()
              .toLowerCase()
              .replaceAll(" ", "")
              .contains(value.trim().toLowerCase().replaceAll(" ", ""))) {
            return element.handle
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          } else if (element.title
              .trim()
              .toLowerCase()
              .replaceAll(" ", "")
              .contains(value.trim().toLowerCase().replaceAll(" ", ""))) {
            return element.title
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          } else {
            return element.tags
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          }
        }).toList();
      } else {
        listOfSearchedQuery = listOfCart.where((element) {
          if (element.handle
              .trim()
              .toLowerCase()
              .replaceAll(" ", "")
              .contains(value.trim().toLowerCase().replaceAll(" ", ""))) {
            return element.handle
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          } else if (element.title
              .trim()
              .toLowerCase()
              .replaceAll(" ", "")
              .contains(value.trim().toLowerCase().replaceAll(" ", ""))) {
            return element.title
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          } else {
            return element.tags
                .trim()
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(value.trim().toLowerCase().replaceAll(" ", ""));
          }
        }).toList();
      }
    });
  }
}
