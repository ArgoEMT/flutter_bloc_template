class JWTToken {
  JWTToken({
    required this.accessToken,
    required this.accessTokenExpiration,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory JWTToken.fromJson(Map<String, dynamic> json) => JWTToken(
        accessToken: json['accessToken'] as String,
        accessTokenExpiration: json['accessTokenExpiration'] as int,
        refreshToken: json['refreshToken'] as String,
        refreshTokenExpiration: json['refreshTokenExpiration'] as int,
      );

  final String accessToken;
  final int accessTokenExpiration;
  final String refreshToken;
  final int refreshTokenExpiration;

  @override
  String toString() => '{\n'
      '\taccessToken: $accessToken,\n'
      '\taccessTokenExpiration: $accessTokenExpiration,\n'
      '\trefreshToken: $refreshToken,\n'
      '\trefreshTokenExpiration: $refreshTokenExpiration,\n'
      '}';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'accessToken': accessToken,
        'accessTokenExpiration': accessTokenExpiration,
        'refreshToken': refreshToken,
        'refreshTokenExpiration': refreshTokenExpiration,
      };
}
