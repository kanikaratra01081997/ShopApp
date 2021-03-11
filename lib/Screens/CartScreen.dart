 import 'package:flutter/material.dart';
import 'package:shoppApp/Providers/Order.dart';
import '../Widgets/CartItem.dart';
import '../Providers/Cart.dart';
import 'package:provider/provider.dart';

 class  CartScreen extends StatelessWidget {

static const routeName="/cart";


  @override
  Widget build(BuildContext context) {
    var cartItem= Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart"),
      
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                  Text("Total"),
                  Chip(label: Text("₹ ${cartItem.totalAmount}"),backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cartItem: cartItem),

                  ]
                  
                )
                ),
            ),
            SizedBox(height: 20,),
            Expanded(child: ListView.builder(itemCount: cartItem.items.length,itemBuilder: (ctx,index)=>
            CItem(
              id: cartItem.items.values.toList()[index].id,
              title: cartItem.items.values.toList()[index].title,
              price: cartItem.items.values.toList()[index].price,
              quantity: cartItem.items.values.toList()[index].quantity,
              prodId: cartItem.items.keys.toList()[index] ,
            )
              )
              )


          ],
        ),
      
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartItem,
  }) : super(key: key);

  final Cart cartItem;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(onPressed: widget.cartItem.totalAmount<=0 || _isLoading ? null: () async {
      setState(() {
        _isLoading=true;
      });
     var order= await Provider.of<Order>(context);
     order.addOrder(widget.cartItem.items.values.toList(),
     widget.cartItem.totalAmount);
     setState(() {
       _isLoading=false;
     });
     widget.cartItem.clear();
    }, child: _isLoading ? CircularProgressIndicator(): Text('Order Now'),);
  }
}