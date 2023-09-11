enum NetworkErrorEnums {
  operationTimeOut('Connection time out'),
  checkYourNetwork('Please, check your network and try again');

  const NetworkErrorEnums(this.message);
  final String message;
}
