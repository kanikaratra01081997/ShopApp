import 'package:flutter/material.dart';
import '../Screens/OrderScreen.dart';
import '../Screens/UserProductScreen.dart';

class appDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(title: Text("hello friend", ) ,
        automaticallyImplyLeading: false,
         
        ),
        Divider(),

        ListTile(title: Text('Shop!') ,
        leading: Icon(Icons.shop),
        onTap:() {Navigator.of(context).pushReplacementNamed('/');
        } ,
        ), 
         Divider(),

        ListTile(title: Text('Orders') ,
        leading: Icon(Icons.payment),
        onTap:() {Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
        } ,

        ),
        Divider(),
        ListTile(
          title: Text("Manage products"),
          leading: Icon(Icons.edit),
          onTap:() {
            Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
          },

        )



      ],),
    );
  }
}