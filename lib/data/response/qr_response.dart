import 'dart:convert';

QrPermission qrPermissionFromJson(String str) => QrPermission.fromJson(json.decode(str));

String qrPermissionToJson(QrPermission data) => json.encode(data.toJson());

class QrPermission {
    QrPermission({
        this.iv = "",
        this.qrCode = "",
    });

    String iv;
    String qrCode;

    factory QrPermission.fromJson(Map<String, dynamic> json) => QrPermission(
        iv: json["iv"],
        qrCode: json["codigoqr"],
    );

    Map<String, dynamic> toJson() => {
        "iv": iv,
        "codigoqr": qrCode,
    };
}
