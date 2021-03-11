import 'package:flutter/material.dart';
import 'package:shoppApp/Providers/Cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem{

final String id;
final double amount;
final List<CartItem> products;
final DateTime dateTime;

OrderItem({@required this.id, @required this.amount, @required this.products,@required  this.dateTime});


}





class Order with ChangeNotifier{
  List<OrderItem> orderItem=[];

  List<OrderItem> get order{
    return [...orderItem];
  }


Future<void> fetchAndAddOrders() async
{

 const url= "https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/orders.json";
 final response = await http.get(url);
 print(json.decode(response.body));

final List<OrderItem> loadedOrder =[];
final extractedData= jsonDecode(response.body) as  Map<String, dynamic>;
if(extractedData==null)
{
  return;
}
extractedData.forEach((orderId ,orderValue) {
  loadedOrder.add(OrderItem(
    id: orderId,
    amount: orderValue['amount'],
    dateTime: DateTime.parse(orderValue['dateTime']), 
    products: (orderValue['products'] as List<dynamic>).map((item) => CartItem(id: item['id'], title: item['title'], quantity: item['quantity'], price: item['price']))
    
  ),
    );
 }
 );
 orderItem=loadedOrder.reversed.toList();
notifyListeners();
}



Future<void> addOrder(List<CartItem> cartproducts, double total) async
{
  
  const url= "https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/orders.json";
  final timeStamp=DateTime.now();
  final response=await http.post(url, body: json.encode({
    'amount':total,
    'dateTime':timeStamp.toIso8601String(),
    'products':cartproducts.map((e) => {
      'id':e.id,
      'price':e.price,
      'title':e.title,
      'quantity':e.quantity,
    }).toList(),

  }
  )
  );
  order.insert(0, 
  OrderItem(
    id: json.decode(response.body)['name'],
   amount: total,
   products: cartproducts,
  dateTime: timeStamp,
  )
  );
  notifyListeners();

}



}