import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/widgets/avatars/circle_avatar_asset.dart';
import 'package:clean_app/widgets/avatars/circle_avatar_file.dart';
import 'package:flutter/material.dart';

class AvatarProfilePicker extends StatelessWidget {

  var pictureTaked;
  Function functionProfile;

  AvatarProfilePicker({
    required this.pictureTaked,
    required this.functionProfile,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pictureTaked==null) {
      return InkWell(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatarAsset(pathAsset: 'assets/images/avatar.png'), 
            Container(
              padding: const EdgeInsets.only(right: dimenNormal),
              child: const Icon(Icons.camera_alt, size: 50)
            )
          ],
        ), 
        onTap: () async {
          functionProfile();
        },
      );
    } else {
      return InkWell(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatarFile(imageFile: pictureTaked),
            Container(
              padding: const EdgeInsets.only(right: dimenNormal),
              child: const Icon(Icons.camera_alt, size: 50)
            )
          ],
        ), 
        onTap: () async {
          functionProfile();
        },
      );
    }
  }
}