import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reem_flora/Google/googleSignin.dart';
import 'package:reem_flora/signin/signIn.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future logout(context) async {
    GoogleSigninApi.logout().whenComplete(() {
      Navigator.push(
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  Text(user.),
          TextButton(
            onPressed: () {
              logout(context);
            },
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
