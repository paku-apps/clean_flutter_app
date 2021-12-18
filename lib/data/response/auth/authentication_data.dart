import 'package:clean_app/data/response/auth/authentication_response.dart';
import 'package:clean_app/data/response/auth/challengue_parameters_response.dart';
import 'package:clean_app/data/response/auth/user_response.dart';

class AuthenticationData {
    AuthenticationData({
        required this.challengeParameters,
        required this.authenticationResult,
        required this.userBd,
    });

    ChallengeParameters challengeParameters;
    AuthenticationResult authenticationResult;
    UserBd userBd;

    factory AuthenticationData.fromJson(Map<String, dynamic> json) => AuthenticationData(
        challengeParameters: ChallengeParameters.fromJson(json["ChallengeParameters"]),
        authenticationResult: AuthenticationResult.fromJson(json["AuthenticationResult"]),
        userBd: UserBd.fromJson(json["userBD"]),
    );

    Map<String, dynamic> toJson() => {
        "ChallengeParameters": challengeParameters.toJson(),
        "AuthenticationResult": authenticationResult.toJson(),
        "userBD": userBd.toJson(),
    };
}