import 'dart:convert';

ApiResultResponse apiResultResponseFromJson(String str) => ApiResultResponse.fromJson(json.decode(str));

String apiResultResponseToJson(ApiResultResponse data) => json.encode(data.toJson());

class ApiResultResponse {
    ApiResultResponse({
        this.status = false,
        this.message = "",
        this.data
    });

    bool status;
    String message;
    dynamic data;

    factory ApiResultResponse.fromJson(Map<String, dynamic> json) => ApiResultResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}