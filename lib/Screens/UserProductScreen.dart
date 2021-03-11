import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Product_provider.dart';
import '../Widgets/UserProductItem.dart';
import '../Widgets/appDrawer.dart';
import '../Screens/EditScreen.dart';


class UserProductScreen extends StatelessWidget {

static const routeName = '/user-products';

Future<void> _refreshProducts(BuildContext context) async
{
await Provider.of<Products>(context, listen : false).fetchHttpResponse();
}
  @override
  Widget build(BuildContext context) {
    final prodData= Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar( title: const Text('add more items'),
      actions: <Widget>[
        IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },
        icon: Icon(Icons.add),
        )
      ],
      ),
      drawer: appDrawer(),
      body: RefreshIndicator(
        onRefresh:()=>_refreshProducts(context) ,
              child: Padding(child: ListView.builder(
          itemBuilder: (ctx,index)=> Column(
                    children: <Widget>[UserProdItem(
              imageUrl: prodData.items[index].imageUrl,
              title: prodData.items[index].title,
              id : prodData.items[index].id,
              ),
              Divider(),
              ]
          ), 
        itemCount: prodData.items.length ,)
         ,padding: EdgeInsets.all(
          10
        ),
        ),
      ),
    );
  }
}