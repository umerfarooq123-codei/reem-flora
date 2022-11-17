import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/Google/googleSignin.dart';
import 'package:reem_flora/constants/constants.dart';
import 'package:reem_flora/forgotPassword/forgotPass.dart';
import 'package:reem_flora/root/rootPage.dart';
import 'package:reem_flora/signup/SignUp.dart';

import '../main.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassVisible = true;
  bool isRemember = false;
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1000,
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

  @override
  void initState() {
    animationController.forward();
    emailController.addListener(() {
      setState(() {});
    });
    passController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //       "assets/images/signinBG.jpg",
            //     ),
            //     fit: BoxFit.cover
            //   ),
            // ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        child: AnimatedBuilder(
                          animation: animationX,
                          builder: (context, child) {
                            final x = animationX.value * size.width;
                            return Transform(
                              transform: Matrix4.translationValues(x, 0, 0),
                              child: child,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .fontSize,
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sign In to your account to continue',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: animationY,
                      builder: (context, child) {
                        final x = animationY.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: emailTextField(
                        350.0,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: animationX,
                      builder: (context, child) {
                        final x = animationX.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: passTextFiled(
                        350.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AnimatedBuilder(
                      animation: animationY,
                      builder: (context, child) {
                        final x = animationY.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: signinButton(
                          context,
                          100.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedBuilder(
                      animation: animationX,
                      builder: (context, child) {
                        final x = animationX.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                setState(() {
                                  isRemember = !isRemember;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Row(
                                  children: [
                                    AnimatedCrossFade(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      crossFadeState: isRemember
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      secondChild: Icon(
                                        Icons.check_box_outline_blank,
                                        size: 19.0,
                                        color: Constants.primaryColor,
                                      ),
                                      firstChild: Icon(
                                        Icons.check_box,
                                        size: 19.0,
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2.0,
                                    ),
                                    Text(
                                      "Remember me",
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
                              ),
                            ),
                          ),
                          gotoForgotPass(
                            context,
                            200.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedBuilder(
                      animation: animationX,
                      builder: (context, child) {
                        final x = animationX.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: signinWithGoogleButton(
                          210.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AnimatedBuilder(
                      animation: animationY,
                      builder: (context, child) {
                        final x = animationY.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: gotoSignupPage(
                          context,
                          200.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    late GoogleSignInAccount? user;
    user = await GoogleSigninApi().login();
    if (!mounted) return;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign in failed"),
        ),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(
            milliseconds: 500,
          ),
          reverseDuration: const Duration(
            milliseconds: 500,
          ),
          child: const RootPage(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  Widget signinWithGoogleButton(double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade300,
            Colors.green.shade400,
            Colors.green.shade500,
          ],
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.8),
          ),
          const BoxShadow(
            blurRadius: 8.0,
            offset: Offset(0, -12),
            color: Colors.transparent,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          onTap: signIn,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  child: Image.asset('assets/images/google.png'),
                ),
                Flexible(
                  child: Text(
                    'Sign In with Google',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signinButton(BuildContext context, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade300,
            Colors.green.shade400,
            Colors.green.shade500,
          ],
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.8),
          ),
          const BoxShadow(
            blurRadius: 8.0,
            offset: Offset(0, -12),
            color: Colors.transparent,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
            context,
            FadeInRoute(
              routeName: '/Home',
              page: const RootPage(),
            ),
          );
            // Navigator.pushNamed(context, '/Home');
            // Navigator.pushReplacement(
            //   context,
            //   PageTransition(
            //     duration: const Duration(
            //       milliseconds: 300,
            //     ),
            //     reverseDuration: const Duration(
            //       milliseconds: 300,
            //     ),
            //     child: const HomePage(),
            //     type: PageTransitionType.fade,
            //   ),
            // );
            // Get.toNamed(RoutesClass.homePage);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gotoForgotPass(BuildContext context, double width) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        hoverColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
            context,
            FadeInRoute(
              routeName: '/ForgotPassword',
              page: const ForgotPassword(),
            ),
          );
        },
        child: SizedBox(
          width: width,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Forgot Password? ',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Reset Here',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget gotoSignupPage(BuildContext context, double width) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        hoverColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
            context,
            FadeInRoute(
              routeName: '/Signup',
              page: const SignUp(),
            ),
          );
          // Navigator.pushNamed(context, '/Signup');
        },
        child: SizedBox(
          width: width,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'New to Reem Folra? ',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Align passTextFiled(double width) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: width,
        child: TextField(
          obscureText: isPassVisible,
          controller: passController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Constants.primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Constants.primaryColor,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPassVisible = !isPassVisible;
                  });
                },
                icon: Icon(
                  isPassVisible ? Icons.visibility_off : Icons.visibility,
                  color: Constants.blackColor,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Constants.blackColor,
              ),
              labelStyle: const TextStyle(color: Colors.black),
              hintText: 'Enter your password',
              labelText: "Password"),
          cursorColor: Constants.blackColor.withOpacity(.5),
        ),
      ),
    );
  }

  Align emailTextField(double width) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: width,
        child: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Constants.primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Constants.primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            suffixIcon: emailController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      emailController.clear();
                    },
                    icon: Icon(Icons.clear, color: Constants.blackColor),
                  )
                : Container(
                    width: 0,
                  ),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Constants.blackColor,
            ),
            hintText: 'Enter your email',
            labelText: 'Email',
            labelStyle: const TextStyle(color: Colors.black),
          ),
          cursorColor: Constants.blackColor.withOpacity(.5),
        ),
      ),
    );
  }
}
