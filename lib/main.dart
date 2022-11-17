import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reem_flora/detail/detail.dart';
import 'package:reem_flora/forgotPassword/forgotPass.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';
import 'package:reem_flora/onBoarding/onBoarding.dart';
import 'package:reem_flora/provider/favoriteProvider.dart';
import 'package:reem_flora/root/rootPage.dart';
import 'package:reem_flora/signin/signIn.dart';
import 'package:reem_flora/signup/SignUp.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

const credentials = r'''
{
  "type": "service_account",
  "project_id": "reem-flora",
  "private_key_id": "009d3c085af0e289eb8e536dd8e61cf72f986f32",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDHRo+GGixCaA8V\ny7zlu+5W2qiVkeSq6xduk7YB66r2YqJQ0wZQuGAhKZOnv93QFRhiYIP+07eClZp/\nZuAMF3Qe/7DbvVJzg9Jlk84o2nJifJR4Psxi9lihkpMVd7SMwHo1fN7lQ2b8H6JU\nWrTdpGabcJiGp/wf9VDS1m35poDAvoayzLEp8c/klreI3Q5UeRCA1+HsMIR6Mgt2\nemTQs1SZgpFq95ALj10s5UF8fibb+d9gf44RJJCduGMx14tHFOsh62hdViHnu+Yb\nBExDpC5QEsXsLte+QwseFoY5rsYS21DZKVTwmEvHlu0ED/s2F6Uc8Hhtox/+41Wz\n8kndxxXpAgMBAAECggEAAPgXfqB6Qg7iQrJszdVHUmaTufEFAqbqACRIdN0q/Ut1\nANt0iEplhWqy7di7xk3NSvCEya437//J0mjCJwLEp8BFaf+gHyRThkxfCLYgt/rL\nwQwEM/E0MF/ESurZ1K5nSK2soktczc1i+1QBRFZXY7yQddymxuyLPanqdwj/G92l\nih8Sp/ktUKp7QTgxVJI9Qo0eMc2nf84L8xhRJj5SykMk2DK3DfAyXNzA2wgpNZny\nVJPnAdEJ+pG7x0ezscR8u3lP7Xdd6yyFoexm+tXvEZOVDTIvoHsnQn0+il+ceWGH\nCW7XjrrkeDP/4hjsL/BrvLh5CPffcnFqEXbO1cG5xQKBgQDmLtrieeGmYEYsA0lF\nXfhQvlSgjP2kVyRMHr0SyjS01d/P/EwF6/x33mEdPPZUcynyKjmQ7eOAH5Qxegxq\nb/UrWmEeGzP0xd/6aKAkiAqrKZfu9EzUGgYWnY+ihd3PMWqQET6F1zqctWdET1Iz\nsDArBRUgJ3asjyU8nh2rnuyrFQKBgQDdoEZgutORg0zLG/7yvviePw54amQmrd3z\nwnX/tq0hY4sOGy5Qt5Ud/lQRW4lJwhlNWfayP7fWeusq1uhD+qC02MKihdl4WRMc\nNw4xy9BQtozc5x5wLuPU6iWz2zZ+Usl7NqvwESV1bhl5bPErzybGwQ+Mt+BtWJZX\nx9fwWYZkhQKBgDY/MpyPJsvEAqWavKjZZYz53g3cTGZvlwFNeTe1ach4Yv+sMOpw\nXBaP1QlD9bWfUnJc2yY5uhTW3GDwp35qFjh6W0ryFEOKYqesApm5afI+oizRbE3M\nOEUaKuCdddG/jqKXPcnjGFAYPFcP7op56lApKXpjcodmUNtBVDK/CH2lAoGAFRCH\nv+fh9gGpyeBGUiIulTPfFzjdfgOmheWku4JMYFEKxXN16nwYczpaGTA/E0CckQqM\n9RIzUfJq6a51cwieP7Iehb39FoA43cSp17fMe+9t4g0hin4ab4E1xit+uXD673gZ\nzX6Dte6aAz2EiqpswBVXegN8FEiIOZ2n+5M2v9UCgYAsgsQJfOi05i2aweSxaSAT\nh31m9dP2VmsUMGmvCOhpUb5kLFtN9JUqV2VWaLLGwI0p09vZZC8U5CxDsHjo+TFD\nTSNJgVFRhHFnRDs7j3rk7njzrMYqgVtFAU+B0ySqY1nYy2WnbkiTpGWYHkduvS1o\nfoGc4WGKdC9saQnwHZnICA==\n-----END PRIVATE KEY-----\n",
  "client_email": "reem-flora@reem-flora.iam.gserviceaccount.com",
  "client_id": "117733231217885294554",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/reem-flora%40reem-flora.iam.gserviceaccount.com"
}
''';
const spredSheetid = "1U7Gy2tXZ3XgVocjeSFdHANK4m00W6dforR_uJiefupg";
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox<ProductModel>("FavoriteProducts");
  await Hive.openBox<Cart>("CartProducts");
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ChangeNotifierProvider(
      create: (context) => FavoritreProvider(),
      child: MaterialApp(
        title: "Reem Flora",
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/Login': (context) => const SignIn(),
          '/Signup': (context) => const SignUp(),
          '/Home': (context) => const RootPage(),
          '/ForgotPassword': (context) => const ForgotPassword(),
          '/Details': (context) => const Detail(product: null),
        },
        // routeInformationParser: AppRoutes.router.routeInformationParser,
        // routeInformationProvider: AppRoutes.router.routeInformationProvider,
        // routerDelegate: AppRoutes.router.routerDelegate,
        // home: OnboardingScreen(),
        // getPages: RoutesClass.routes,
        // initialRoute: RoutesClass.onBoarbing,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute({required this.page, required String routeName})
      : super(
          settings: RouteSettings(name: routeName), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
