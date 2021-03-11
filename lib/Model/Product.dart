

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
 bool isFavourite;



  Product({@required this.id,@required this.title,@required this.description,@required this.price, @required this.imageUrl, this.isFavourite=false});



void toggleFavourite() async
{

// first save this and roll back if it fails , optimistic
final oldStatus=isFavourite;
isFavourite= !isFavourite;
notifyListeners();

final url= "https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/products/$id.json";
try{
 final response= await http.patch(url,
body:json.encode(
{
  'isFavourite':isFavourite,
}
) 
);
if(response.statusCode >=400)
{
 isFavourite=oldStatus;
  notifyListeners();
}
}catch(error)
{
  isFavourite=oldStatus;
  notifyListeners();
}

}

}