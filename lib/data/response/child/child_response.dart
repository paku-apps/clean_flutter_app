import 'dart:convert';

List<ChildResponse> childResponseFromJson(String str) => List<ChildResponse>.from(json.decode(str).map((x) => ChildResponse.fromJson(x)));

String childResponseToJson(List<ChildResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildResponse {
    ChildResponse({
        this.id = "0",
        this.names = "",
        this.lastname = "",
        this.grade = "",
        this.level = "",
    });

    String id;
    String names;
    String lastname;
    String grade;
    String level;

    factory ChildResponse.fromJson(Map<String, dynamic> json) => ChildResponse(
        id: json["id"],
        names: json["names"],
        lastname: json["lastname"],
        grade: json["grade"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "names": names,
        "lastname": lastname,
        "grade": grade,
        "level": level,
    };
}
