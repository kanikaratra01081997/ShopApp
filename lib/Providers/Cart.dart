


import 'package:flutter/material.dart';

class CartItem{
  String id;
  String title;
  final int quantity;
  final double price;

  CartItem({ @required this.id, @required this.title, @required this.quantity,@required this.price});

}

class Cart with ChangeNotifier{

Map<String,CartItem> _items={};

Map<String,CartItem> get items
{
  return { ..._items};
}




double get totalAmount{
 var total=0.0;
 _items.forEach(
   (key, cartItem) {
   total+=cartItem.price*cartItem.quantity;
  }
  );
  return total;
}

int get itemCount{
  return _items==null? 0: _items.length;
}

 void addItem(String prodId, double price, String title )
{

if(_items.containsKey(prodId)){
  _items.update(prodId, (value) => CartItem(id: value.id,title: value.title, price: value.price,quantity: value.quantity+1 ) );
}
else{
  _items.putIfAbsent(prodId,()=> CartItem (id: DateTime.now().toString(),title: title, price: price,quantity: 1)); 
}
notifyListeners();

}


void removeItem(String prodId)
{
_items.remove(prodId);
notifyListeners();
}

void clear()
{
  _items={};
  notifyListeners();
}


void removeSingleItem(String prodId)
{
  if(!items.containsKey(prodId))
  {
return ;
  }
  if(items[prodId].quantity>1)
  {
    items.update(prodId, (existingCartItems) => CartItem(id: existingCartItems.id, title: existingCartItems.title, quantity: existingCartItems.quantity-1 , price: existingCartItems.price));
  }
  else
  {
    items.remove(prodId); 
  }
notifyListeners(); 
}


}