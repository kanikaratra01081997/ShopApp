import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppApp/Providers/Product_provider.dart';
import 'package:shoppApp/Screens/ProductDetailScreen.dart';
import 'package:shoppApp/Screens/ProductOverviewScreen.dart';
import './Providers/Cart.dart';
import './Screens/CartScreen.dart';
import './Providers/Order.dart';
import './Screens/OrderScreen.dart';
import './Screens/UserProductScreen.dart';
import './Screens/EditScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(providers: [
          ChangeNotifierProvider(
         create: (BuildContext context) =>Products(),
          ),

         ChangeNotifierProvider(
           create: (BuildContext context)=>Cart(),
         ),

         ChangeNotifierProvider(create: (BuildContext context)=> Order(),)

    ],
          child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          accentColor: Colors.amber, 
        primarySwatch: Colors.blue),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailscreen.routeName : (ctx) => ProductDetailscreen(),
          CartScreen.routeName : (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx)=> OrderScreen(),
          UserProductScreen.routeName: (ctx)=> UserProductScreen(),
          EditProductScreen.routeName:(ctx)=> EditProductScreen(),
        },
      ),
    );
  }
}




// class HomePage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
// return Scaffold(
//   appBar: AppBar(title: Text('Shop App'),
//   ),

//   body:Center(
//     child:Text('hello shop'),

//   ) ,
// );
//   }

// }



