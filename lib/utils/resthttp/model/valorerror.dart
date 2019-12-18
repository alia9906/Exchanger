
class ResponseOrError{

  ResponseOrError({this.response , this.error});

  dynamic response;
  dynamic error;

  

  @override
  String toString() {
    // TODO: implement toString
    if(error != null){
      return error.toString();
    }
    return super.toString();
  }
}