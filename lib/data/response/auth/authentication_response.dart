
class AuthenticationResult {
    AuthenticationResult({
        this.accessToken = "",
        this.expiresIn = 0,
        this.tokenType = "",
        this.refreshToken = "",
        this.idToken = ""
    });

    String accessToken;
    int expiresIn;
    String tokenType;
    String refreshToken;
    String idToken;

    factory AuthenticationResult.fromJson(Map<String, dynamic> json) => AuthenticationResult(
        accessToken: json["AccessToken"],
        expiresIn: json["ExpiresIn"],
        tokenType: json["TokenType"],
        refreshToken: json["RefreshToken"],
        idToken: json["IdToken"],
    );

    Map<String, dynamic> toJson() => {
        "AccessToken": accessToken,
        "ExpiresIn": expiresIn,
        "TokenType": tokenType,
        "RefreshToken": refreshToken,
        "IdToken": idToken,
    };
}