import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppApp/Providers/Product_provider.dart';
import '../Widgets/ProductItem.dart';

class ProductGrid extends StatelessWidget {
  // const ProductGrid({
  //   Key key,
  //   @required List<Product> loadedproduct,
  // }) : _loadedproduct = loadedproduct, super(key: key);

  // final List<Product> _loadedproduct;

    var showFavouriteOnly;

   ProductGrid(this.showFavouriteOnly);


  @override
  Widget build(BuildContext context) {



   


    final productData =Provider.of<Products>(context);
    final products= showFavouriteOnly ? productData.favouriteItems : productData.items;



    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3/2, 
        crossAxisCount: 2,
        crossAxisSpacing: 20,
         mainAxisSpacing: 10,
         ),
          itemBuilder: (ctx,index)=>ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(  ),
              ),
          itemCount: products.length,
          );
  }
}