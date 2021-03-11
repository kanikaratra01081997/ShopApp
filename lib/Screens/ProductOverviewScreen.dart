import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppApp/Providers/Product_provider.dart';
import 'package:shoppApp/Screens/CartScreen.dart';
import '../Widgets/appDrawer.dart';
import '../Screens/ProductGrid.dart';
import '../Widgets/badge.dart';
import '../Providers/Cart.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

var _isInIt=true;
var _isLoading=false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<Products>(context).fetchHttpResponse();
    //not a right place to add , because context is not available;
    // Future.delayed(Duration.zero).then((_) => Provider.of<Products>(context).fetchHttpResponse());
    //its a hack not preferred still
  
  }
  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading=true;
    }
    );
    if(_isInIt)
    {
    Provider.of<Products>(context).fetchHttpResponse().then(
      (_) => {
      setState((){
        _isLoading=false;
      })
    }
    );
  }
    _isInIt=false;
    super.didChangeDependencies();
  }

  var _showFavOnly = false;
  Widget build(BuildContext context) {
    // final ProdContainer= Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My shopp'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedVal) {
                setState(() {
                  if (selectedVal == FilterOptions.Favourites) {
                    // ProdContainer.showFavouriteOnly();
                    _showFavOnly = true;
                  } else {
                    // ProdContainer.showAllOnly();
                    _showFavOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text(
                        'Only Favourites',
                      ),
                      value: FilterOptions.Favourites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.All,
                    )
                  ]),
         Consumer<Cart>(builder: (_,cart, ch)=>Badge(
              child: ch,
              value: cart.itemCount.toString(),
              ),
             child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed( CartScreen.routeName);
                },
              ), 
              ) 
        ],
      ),
      drawer: appDrawer(),
      body:
      // _isLoading ? Center(child:CircularProgressIndicator()): 
      ProductGrid(_showFavOnly),
    );
  }
}

