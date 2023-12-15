/// Constant class to handle base url and endpoints
class ApiConstant {
  ApiConstant._();

  static const _baseUrl = 'http://restapi.adequateshop.com';

  static const registration = '$_baseUrl/api/authaccount/registration';
  static const login = '$_baseUrl/api/authaccount/login';

  static const isLogin = "isLogin";
  static const userName = "userName";
}
