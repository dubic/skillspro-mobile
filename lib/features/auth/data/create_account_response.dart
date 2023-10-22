class CreateAccountResponse {
  final bool verified;
  final int tokenTtlSecs;

  CreateAccountResponse(this.verified, this.tokenTtlSecs);

  static CreateAccountResponse? create(dynamic data) {
    if (data == null) {
      return null;
    }
    return CreateAccountResponse(data['verified'], data['tokenTtlSecs']);
  }

  @override
  String toString() {
    return 'verified=$verified, tokenTtlSecs=$tokenTtlSecs';
  }
}
