import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppApp/Widgets/appDrawer.dart';
import '../Providers/Order.dart';
import '../Widgets/OrdeItem.dart';


 class OrderScreen  extends StatefulWidget {
   static const routeName='/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  var _isLoading = false;

@override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading=true;
      });
      Provider.of<Order>(context,listen: false).fetchAndAddOrders();

      setState(() {
        _isLoading=false;
      });

    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text("shop app"),),
      drawer: appDrawer(),
      body:_isLoading? CircularProgressIndicator(): ListView.builder(
        itemCount: orderData.order.length,
        itemBuilder: (ctx, index){ return OItem(orderData.order[index]);},
      ) ,
      
    );
  }
}