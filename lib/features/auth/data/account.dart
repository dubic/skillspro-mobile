class Account {
  final String name;
  final String email;
  final bool verified;

  Account(this.name, this.email, this.verified);

  static Account create(dynamic data) {
    return Account(data['name'], data['email'], data['verified']);
  }

  @override
  String toString() {
    return 'name=$name, email=$email, verified=$verified';
  }
}
