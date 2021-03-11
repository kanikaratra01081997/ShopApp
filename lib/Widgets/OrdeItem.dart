
import 'package:flutter/material.dart';
import '../Providers/Order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

 class OItem extends StatefulWidget {
   final OrderItem order ;

   OItem(this.order);

  @override
  _OItemState createState() => _OItemState();
}

class _OItemState extends State<OItem> {

  var _expanded=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.order.amount}'),
            subtitle: Text(DateFormat('dd /mm /yyyy hh: mm ').format(widget.order.dateTime)
            ),
            trailing: IconButton(icon: Icon(
              _expanded? Icons.expand_less :
              Icons.expand_more), 
              onPressed: (){
            setState(() {
              _expanded = !_expanded ;
            });
            },),
          ),
          if(_expanded)
            Container(height: min( widget.order.products.length*20.0+100.0,180.0),
            child: ListView(children: widget.order.products.map((e) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
              Text(e.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('${e.quantity} X Rupee ${e.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
            ],)).toList(),
            )
            )
         
        ],
      ),
    );
  }
}