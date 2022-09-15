import 'dart:convert';

QrPermission qrPermissionFromJson(String str) => QrPermission.fromJson(json.decode(str));

String qrPermissionToJson(QrPermission data) => json.encode(data.toJson());

class QrPermission {
    QrPermission({
        this.qrCode = 0,
    });

    int qrCode;

    factory QrPermission.fromJson(Map<String, dynamic> json) => QrPermission(
        qrCode: json["codigoqr"],
    );

    Map<String, dynamic> toJson() => {
        "codigoqr": qrCode,
    };
}
