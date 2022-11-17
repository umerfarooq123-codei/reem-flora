import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/constants/constants.dart';

import '../signin/signIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController rePassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isPassVisible = true;
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
    rePassController.addListener(() {
      setState(() {});
    });
    nameController.addListener(() {
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
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
                              'Welcome user',
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
                              'Sign up to join',
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
                      child: fullNanmeTextField(
                        350.0,
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
                      child: passTextFiled(
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
                      child: rePassTextFiled(
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
                        child: signUpButton(
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
                        child: signUpWithGoogle(
                          210.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                        child: gotoLoginPage(
                          context,
                          200.0,
                        ),
                      ),
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

  Widget gotoLoginPage(BuildContext context, double width) {
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
                  TextSpan(
                    text: 'Have an Account? ',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Login',
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

  Widget signUpWithGoogle(double width) {
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
          onTap: () {},
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
                    'Sign Up with Google',
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

  Widget signUpButton(double width) {
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
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget passTextFiled(double width) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: width,
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          obscureText: isPassVisible,
          controller: passController,
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

  Widget rePassTextFiled(double width) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: width,
        child: TextField(
          obscureText: isPassVisible,
          controller: rePassController,
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
              hintText: 'Confirm password',
              labelText: "Confirm"),
          cursorColor: Constants.blackColor.withOpacity(.5),
        ),
      ),
    );
  }

  Widget emailTextField(double width) {
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

  Widget fullNanmeTextField(double width) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: width,
        child: TextField(
          controller: nameController,
          keyboardType: TextInputType.name,
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
            suffixIcon: nameController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      nameController.clear();
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
            hintText: 'Enter your fullname',
            labelText: 'Fullname',
            labelStyle: const TextStyle(color: Colors.black),
          ),
          cursorColor: Constants.blackColor.withOpacity(.5),
        ),
      ),
    );
  }
}
