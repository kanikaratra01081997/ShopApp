import 'package:flutter/material.dart';
import '../Screens/ProductDetailScreen.dart';

import '../Model/Product.dart';
import 'package:provider/provider.dart';
import '../Providers/Cart.dart';

class ProductItem extends StatelessWidget{
// final String id;
//  final String title;
// final String imageUrl;


// ProductItem({this.id, this.title, this.imageUrl});

  Widget build(BuildContext context){
    final prod= Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context,listen: false);
    // bool fav = prod.isFavourite;
    // Icon ic;
    // if(fav)
    // {
    //  ic= Icon(Icons.favorite);
    // }
    // else
    // {
    //     ic= Icon(Icons.favorite_border);
    // }


    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
          child: GridTile(child: GestureDetector(
                      onTap: (){

                       Navigator.of(context).pushNamed(
                         ProductDetailscreen.routeName,
                        arguments: prod.id,
                    );

                      },
                      child: Image.network(prod.imageUrl, fit: BoxFit.cover,
      ),
          ),

      footer: GridTileBar(
        title: Text(prod.title, 
      textAlign: TextAlign.center
      ),

      leading: IconButton(
        icon:    Icon(prod.isFavourite? Icons.favorite : Icons.favorite_border),
      color: Theme.of(context).accentColor,
  
      onPressed:()=> prod.toggleFavourite(),
      ),
      backgroundColor: Colors.black54,

      trailing: IconButton(icon: Icon(Icons.shopping_cart),
      color: Theme.of(context).accentColor,
      onPressed:(){
        cart.addItem(prod.id, prod.price, prod.title);

        final snackbar = SnackBar(content:Text('added to the cart'), action: SnackBarAction(onPressed: (){

          cart.removeSingleItem(prod.id);
        }, label: 'UNDO',
        ),
        );
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(snackbar);
        
      } ,
      ),
      )
      ),
    );
  }
}



