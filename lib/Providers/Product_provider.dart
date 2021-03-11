import 'dart:core';

import 'package:flutter/material.dart';
import '../Model/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/HttpException.dart';


class Products extends ChangeNotifier{


List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
];


var showFavOnly =false;



List<Product> get items {
  if(showFavOnly==true)
{
  items.where((prodItem)=> prodItem.isFavourite).toList();
}
  return [..._items];
}


Product findById(String prodId)
{
 return  _items.firstWhere((element) => element.id==prodId);
}



Future<void> addProduct( Product product) async
{

  // future
var url = 'https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/products.json';
// return (http.post(url,
// //headers:
// body: json.encode({
//   'title': product.title,
//   'description':product.description,
//   'imageUrl': product.imageUrl,
//   'price':product.price,
//   'isFavourite':product.isFavourite,
// })
// ).then((response){
// print(json.decode(response.body) );
// final   newProd= Product(
//   description: product.description,
// imageUrl: product.imageUrl,
//  price: product.price,
//  id: json.decode(response.body)['name'],
//  title: product.title,
// );
// _items.add(newProd);
//   notifyListeners();

// }
// )
// ).catchError((error){
//   print(error);
//   throw error;
// });


//async await
try{
  var res = await http.post(url, 
body :json.encode(
  {
    'title': product.title,
  'description':product.description,
  'imageUrl': product.imageUrl,
  'price':product.price,
  'isFavourite':product.isFavourite,
}
)
);

final   newProd= Product(
  description: product.description,
imageUrl: product.imageUrl,
 price: product.price,
 id: json.decode(res.body)['name'],
 title: product.title,
);
_items.add(newProd);
  notifyListeners();
}catch (err)
{
print(err);
throw(err);
}

//Json -- javascript object notation , format for storing data nd transmitting it.
//product;
//need conversion to json , 

}



List<Product> get favouriteItems{
  return _items.where((ele) => ele.isFavourite).toList();
}

void updateProduct(Product product, String id) async
{


  final prodIndex= _items.indexWhere((element) => element.id==id);
  if(prodIndex>0)
  {
      final url = "https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/products/$id.json";
     await http.patch(url, body:json.encode({
        'title':product.title,
        'description':product.description,
        'imageUrl':product.imageUrl,
        'price':product.price
      }
      )
      );
    _items[prodIndex]=product;
  }
  else{
   print('...');  
  }
  notifyListeners();
}


Future<void> deleteProduct(String id) async
{

   final url = "https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/products/$id.json";
   final _existingproductIndex= _items.indexWhere((element) => element.id==id);
   var existingProd= _items[_existingproductIndex];

    _items.removeAt(_existingproductIndex);
  notifyListeners();
   final response=  await http.delete(url);

     if(response.statusCode >=400)
     {
    _items.insert(_existingproductIndex,existingProd);
     notifyListeners();
       throw HttpException('could not delete the item ');
     }
  existingProd=null;

}




Future<void> fetchHttpResponse() async{
  const url = "https://shop-app-flutter-eb695-default-rtdb.firebaseio.com/products.json";
  try{

    final response = await http.get(url);
    print(json.decode(response.body));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> loadedProducts=[];
    extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(id: prodId,
        title: prodData['title'],
        description: prodData['description'],
        imageUrl: prodData['imageUrl'],
        price: prodData['price'],
        isFavourite: prodData['isFavourite'],
        )
        );
     });
_items=loadedProducts;
notifyListeners();
  }
  catch (err){
    throw(err);
  }
}

// void showFavouriteOnly()
// {
//  showFavOnly=true;
//  notifyListeners();
// }
// void showAllOnly()
// {
//   showFavOnly=false;
//   notifyListeners();
// }

}