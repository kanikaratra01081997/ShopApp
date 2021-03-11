import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
 
import 'package:shoppApp/Providers/Cart.dart';class CItem extends StatelessWidget {
   final String  id;
   final double price;
   final int quantity;
   final String title;
   final String prodId;

   CItem({this.id,this.quantity,this.price, this.title,this.prodId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
    
          key: ValueKey(id),
          confirmDismiss:(direction){

            return showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text("are you sure?"), content: Text(" do you want to delete?"),
            actions: <Widget>[
              FlatButton(onPressed: (){ Navigator.of(ctx).pop(true);}, child: Text("yes, delete it!")),
              FlatButton(onPressed: (){Navigator.of(ctx).pop(false);}, child: Text('no, dont delete')),
            ],
            )
            );
          } ,
          background: Container(color: Theme.of(context).errorColor,
          child: Icon(Icons.delete,
          color: Colors.white,
          size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(10),

          ),
          
          onDismissed: (direction){Provider.of<Cart>(context,listen: false).removeItem(prodId);},
          direction: DismissDirection.endToStart,
          child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(padding: EdgeInsets.all(10),

        child:ListTile(
          
          leading: CircleAvatar(child: Padding(padding: EdgeInsets.all(10),child: FittedBox(child: Text('$price',))),
        ),
        title: Text(title),
        subtitle: Text('Total: ${price*quantity}'),
        trailing: Text('${quantity} x'),
        ) ,
        ),
        
      ),
    );
  }
}