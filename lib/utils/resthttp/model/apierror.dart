class ApiError extends Error{
  final String message;
  final dynamic originalError;

  ApiError({this.message , this.originalError});

  @override
  String toString() {
    // TODO: implement toString
    if(message != null)
        return message;
    if(originalError != null)
        return originalError.toString();
    return super.toString();    
  }
}