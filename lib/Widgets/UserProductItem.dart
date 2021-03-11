import 'package:flutter/material.dart';
import 'package:shoppApp/Providers/Product_provider.dart';
import '../Screens/EditScreen.dart';
import 'package:provider/provider.dart';

class UserProdItem  extends StatelessWidget {
final String title;
final String imageUrl;
final String id;

UserProdItem({this.title, this.imageUrl, this.id});
  @override
  Widget build(BuildContext context) {
    final scaffold= Scaffold.of(context);
    return ListTile(
      
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ) ,
      title: Text(title),
      trailing: Container(
        width: 100,
              child: Row(children:<Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id );
          }, color: Theme.of(context).primaryColor,),
          IconButton(icon: Icon(Icons.delete),onPressed: ()async{
            try
            { 
              await Provider.of<Products>(context).deleteProduct(id);
            }catch(error)
            {
             scaffold.showSnackBar(SnackBar(content:Text("deleting failed"),));
            }
           
          },color: Theme.of(context).primaryColor,)

        ]
        ),
      ),
    );
  }
}