import 'account.dart';

class AuthResponse {
  final String token;
  final Account account;

  AuthResponse(this.token, this.account);

  static AuthResponse create(dynamic data) {
    var authResponse = AuthResponse(data['token'], Account.create(data['account']));
    return authResponse;
  }

  dynamic getData()=> {'token' : token, 'account' : account.getData()};

  @override
  String toString() {
    return 'token=$token, account=$account';
  }
}
