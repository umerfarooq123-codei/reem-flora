// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';
import 'package:reem_flora/provider/favoriteProvider.dart';
import 'package:reem_flora/signin/signIn.dart';

import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController(initialPage: 0);
  final flowerList = [
    "assets/images/background6.jpg",
    "assets/images/background7.jpg",
    "assets/images/background8.jpg",
  ];
  int currentIndex = 0;
  final titles = [
    //Onboarding texts
    "Find plants anywhere",
    "Flower that everyone loves",
    "All flower species collection",
  ];
  final desc = [
    //Onboarding texts
    "Discover plants you want by your location or neighborhood",
    "Find a perfect flower",
    "Find almost all types of flower that you like here.",
  ];

  @override
  Widget build(BuildContext context) {
    Hive.openBox<ProductModel>("FavoriteProducts");
    Hive.openBox<Cart>("CartProducts");
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              // Positioned.fill(
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: double.infinity,
              //     child: Image.asset(
              //       flowerList[currentIndex],
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Positioned.fill(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  controller: pageController,
                  itemCount: flowerList.length,
                  itemBuilder: (context, index) => createPage(
                    image: flowerList[index],
                    title: titles[index],
                    description: desc[index],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedCrossFade(
                    secondCurve: Curves.bounceOut,
                    firstCurve: Curves.bounceIn,
                    firstChild: skipButton(context, 40),
                    secondChild: Container(),
                    crossFadeState: currentIndex == 2
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                child: Row(
                  children: _buildIndicator(),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 30,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentIndex != 2) {
                          pageController.animateToPage(currentIndex + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              reverseDuration: const Duration(
                                milliseconds: 500,
                              ),
                              child: const SignIn(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget skipButton(BuildContext context, double width) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        hoverColor: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.grey,
        onTap: () {
          Navigator.push(
            context,
            FadeInRoute(
              routeName: '/Login',
              page: const SignIn(),
            ),
          );
          // context.go('/Login');
          // Navigator.pushReplacement(
          //   context,
          // PageTransition(
          //   duration: const Duration(
          //     milliseconds: 300,
          //   ),
          //   reverseDuration: const Duration(
          //     milliseconds: 300,
          //   ),
          //   child: const SignIn(),
          //   type: PageTransitionType.fade,
          // ),
          // );
          // Get.toNamed(RoutesClass.login);
        },
        child: SizedBox(
          width: width,
          height: width,
          child: Center(
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: isActive ? 6 : 4,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 4.0,
        //     offset: const Offset(0.0, 8.0),
        //     color: Colors.black.withOpacity(0.6),
        //   ),
        //   const BoxShadow(
        //     blurRadius: 4.0,
        //     offset: Offset(0.0, -8.0),
        //     color: Colors.transparent,
        //   ),
        // ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

// ignore: must_be_immutable
class createPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const createPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 200,
          ),
          Expanded(
            child: Text(
              "Reem Flora",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
