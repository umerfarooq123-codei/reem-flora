import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/constants/constants.dart';
import 'package:reem_flora/signin/signIn.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
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
    super.initState();
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: animationX,
                      builder: (context, child) {
                        final x = animationX.value * size.width;
                        return Transform(
                          transform: Matrix4.translationValues(x, 0, 0),
                          child: child,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: Text(
                          'Forgot\nPassword',
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
                      child: Align(
                        alignment: Alignment.center,
                        child: resetPassButton(
                          context,
                          100.0,
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
                        child: gotoSigninPage(
                          context,
                          200.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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

  Widget resetPassButton(BuildContext context, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.green.shade300,
            Colors.green.shade400,
            Colors.green.shade500,
          ],
        ),
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
      child: SizedBox(
        width: width,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              // Navigator.push(
              //   context,
              //   PageTransition(
              // duration: const Duration(
              //   milliseconds: 500,
              // ),
              // reverseDuration: const Duration(
              //   milliseconds: 500,
              // ),
              //     child: const RootPage(),
              //     type: PageTransitionType.fade,
              //     childCurrent: const SignIn(),
              //   ),
              // );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'Reset',
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
      ),
    );
  }

  Widget gotoSigninPage(BuildContext context, double width) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        hoverColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          width: width,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Have an Account? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: Constants.primaryColor,
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
}
