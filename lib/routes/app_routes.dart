import 'package:go_router/go_router.dart';
import 'package:reem_flora/forgotPassword/forgotPass.dart';
import 'package:reem_flora/onBoarding/onBoarding.dart';
import 'package:reem_flora/root/rootPage.dart';
import 'package:reem_flora/signin/signIn.dart';
import 'package:reem_flora/signup/SignUp.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) {
          return const SignIn();
        },
      ),
      GoRoute(
        path: '/Signup',
        builder: (context, state) {
          return const SignUp();
        },
      ),
      GoRoute(
        path: '/ForgotPassword',
        builder: (context, state) {
          return const ForgotPassword();
        },
      ),
      GoRoute(
        path: '/Home',
        builder: (context, state) {
          return const RootPage();
        },
      ),
    ],
  );
}
