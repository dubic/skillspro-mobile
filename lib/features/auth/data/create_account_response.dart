class CreateAccountResponse {
  final String email;
  final bool verified;
  final int tokenTtlSecs;

  CreateAccountResponse(this.email, this.verified, this.tokenTtlSecs);

  static CreateAccountResponse? create(String email, dynamic data) {
    if (data == null) {
      return null;
    }
    return CreateAccountResponse(email, data['verified'], data['tokenTtlSecs']);
  }

  @override
  String toString() {
    return 'verified=$verified, tokenTtlSecs=$tokenTtlSecs';
  }
}
