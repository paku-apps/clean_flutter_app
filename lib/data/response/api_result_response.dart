import 'dart:convert';

ApiResultResponse apiResultResponseFromJson(String str) => ApiResultResponse.fromJson(json.decode(str));

String apiResultResponseToJson(ApiResultResponse data) => json.encode(data.toJson());

class ApiResultResponse {
    ApiResultResponse({
        this.code = "",
        this.message = "",
        this.data
    });

    String code;
    String message;
    dynamic data;

    factory ApiResultResponse.fromJson(Map<String, dynamic> json) => ApiResultResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}