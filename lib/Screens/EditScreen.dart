import 'package:flutter/material.dart';
import '../Model/Product.dart';
import 'package:provider/provider.dart';
import '../Providers/Product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  var _isLoading= false;

  final _form = GlobalKey<FormState>();
  var editedProduct = Product(
    id: null,
    description: "",
    imageUrl: "",
    price: 0,
    title: "",
  );
  var _isInIt = true;

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInIt) {
      String prodId = ModalRoute.of(context).settings.arguments as String;

      if (prodId != null) {
        editedProduct =
            Provider.of<Products>(context, listen: false).findById(prodId);
        _initValues = {
          'title': editedProduct.title,
          'description': editedProduct.description,
          'price': editedProduct.price.toString(),
          // 'imageUrl': editedProduct.imageUrl,
          'imageUrl':'',
        };
        _imageUrlController.text=editedProduct.imageUrl;
      }
    }
    _isInIt = false;
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
  }

  Future<void> _saveForm()  async{
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

  setState(() {
    _isLoading=true;
  });

    if(editedProduct.id!=null)
    {
       await Provider.of<Products>(context,listen: false).updateProduct(editedProduct,editedProduct.id);
   
    }
    else
    {
      try{
          await Provider.of<Products>(
      context, listen: false)
      .addProduct(editedProduct);
      }
      catch(err)
      {
        showDialog<Null>(context:context, builder:(ctx)=>AlertDialog(
        title:Text("this is an error"),
      content: Text("something went wrong"+err.toString(),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.of(ctx).pop();
        },
         child: Text("Okay"),)

      ],
       )
      );
        
      }


         setState(() {
         _isLoading=false;
       });
        Navigator.of(context).pop();
      // finally{
      //           setState(() {
      //     _isLoading=false;
      //   });
      //   Navigator.of(context).pop();

      // }
    
      // .catchError((error){
    //     return 
    //   showDialog<Null>(context:context, builder:(ctx)=>AlertDialog(
    //     title:Text("this is an error"),
    //   content: Text("something went wrong"+error.toString(),
    //   ),
    //   actions: <Widget>[
    //     FlatButton(onPressed: (){
    //       Navigator.of(ctx).pop();
    //     },
    //      child: Text("Okay"),)

    //   ],
    //    )
    //   );
    //   }
    //   ).then(
    //   (_) {
    //     setState(() {
    //       _isLoading=false;
    //     });
    //     Navigator.of(context).pop();
    //   } 
    // );

    }

    // Navigator.of(context).pop();
    // print(editedProduct.title);
    // print(editedProduct.description);
    // print(editedProduct.price);
    // print(editedProduct.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading? Center(child: CircularProgressIndicator(),) : Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: "what people call you?",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                 
                  editedProduct = Product(
                    title: value,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                    description: editedProduct.description,
                    id: editedProduct.id,
                    isFavourite : editedProduct.isFavourite,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter a title";
                  } else
                    return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: "enter price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  editedProduct = Product(
                    title: editedProduct.title,
                    price: double.parse(value),
                    imageUrl: editedProduct.imageUrl,
                    description: editedProduct.description,
                   id: editedProduct.id,
                    isFavourite : editedProduct.isFavourite,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter a price";
                  }
                  if (double.parse(value) == null) {
                    return "please enter a vlaid no.";
                  }

                  if (double.parse(value) <= 0) {
                    return "please enter postive no";
                  } else
                    return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: "enter description of the product",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  editedProduct = Product(
                    title: editedProduct.title,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                    description: value,
                    id: editedProduct.id,
                    isFavourite : editedProduct.isFavourite,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "enter description";
                  }

                  if (value.length < 5) {
                    return "enter text should be greater than length 5";
                  } else
                    return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a url')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        editedProduct = Product(
                          title: editedProduct.title,
                          price: editedProduct.price,
                          imageUrl: value,
                          description: editedProduct.description,
                           id: editedProduct.id,
                        isFavourite : editedProduct.isFavourite,
                        );
                      },
                      onEditingComplete: (){
                        setState(() {
                          
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter url";
                        } else if (!value.startsWith("http") &&
                            !value.startsWith("https")) {
                          return "enter valid urls";
                        } else if (!value.endsWith("jpeg") &&
                            !value.endsWith("jpg") &&
                            !value.endsWith("png")) {
                          return "please enter correct type of image";
                        } else
                          return null;
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
