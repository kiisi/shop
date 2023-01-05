import 'package:flutter/material.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/auth_screen.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/splash_screen.dart';
import 'package:shop/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) {
            return Products(ctx.read<Auth>().token, ctx.read<Auth>().userId);
          },
          update: (ctx, auth, previousProduct) {
            return previousProduct!..update(previousProduct.items);
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) =>
              Orders(ctx.read<Auth>().token, ctx.read<Auth>().userId),
          update: (ctx, auth, previousOrder) =>
              previousOrder!..update(previousOrder.order),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop',
          theme: ThemeData(
            primaryColor: Colors.purple,
            primarySwatch: Colors.purple,
            fontFamily: 'Lato',
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.purple,
                  secondary: Colors.deepOrange,
                ),
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen()
          },
        ),
      ),
    );
  }
}
