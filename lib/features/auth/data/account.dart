class Account {
  final String name;
  final String email;
  final bool verified;
  String? imageUrl;

  Account(this.name, this.email, this.verified);

  static Account create(dynamic data) {
    return Account(data['name'], data['email'], data['verified'])..imageUrl = data['imageUrl'];
  }

  @override
  String toString() {
    return 'name=$name, email=$email, verified=$verified, imageUrl=$imageUrl';
  }

  getData() => {'name': name, 'email': email, 'verified': verified, 'imageUrl': imageUrl};
}
