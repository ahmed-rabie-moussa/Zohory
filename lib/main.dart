import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zohory/providers/flowers_provider.dart';
import './providers/auth.dart';
import './screens/product_details_screen.dart';
import './screens/product_screen.dart';
import './screens/activation_screen.dart';
import './screens/signup_screen.dart';
import './screens/login_screen.dart';
import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Flowers>(
          update: (ctx, auth, previousProducts) => Flowers(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.exo2TextTheme(Theme.of(context).textTheme),
            appBarTheme: AppBarTheme(textTheme: GoogleFonts.exo2TextTheme(Theme.of(context).textTheme),),
            primaryColor: Colors.pinkAccent,
            primaryColorDark: Colors.pink,
            accentColor: Color(0xffd5609e),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          home:
          // MyHomePage(),
          auth.isAuth
              ? MyHomePage()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState ==
                ConnectionState.waiting
                ? SplashScreen()
                : LoginScreen(),
          ),
          routes: {
            SignUpScreen.route : (context)=> SignUpScreen(),
            LoginScreen.route : (context)=> LoginScreen(),
            MyHomePage.route : (context)=> MyHomePage(),
            ProductDetailsScreen.route : (context)=> ProductDetailsScreen(),
            ProductScreen.route : (context)=> ProductScreen(),
          },
        ),
      ),
    );
  }
}
