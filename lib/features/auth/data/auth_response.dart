import 'account.dart';

class AuthResponse {
  final String token;
  final Account account;
  dynamic _data;

  AuthResponse(this.token, this.account);

  static AuthResponse create(dynamic data) {
    var authResponse = AuthResponse(data['token'], Account.create(data['account']));
    authResponse._data = data;
    return authResponse;
  }

  dynamic getData()=> _data;

  @override
  String toString() {
    return 'token=$token, account=$account';
  }
}
