class HttpException implements Exception{
final String message;

HttpException(this.message);

@override
  String toString() {
    // TODO: implement toString
    return message;
  }

}
//making custom exception handlers
//implemnts--asbstract class can not directly instatntiate//
//forced to use method