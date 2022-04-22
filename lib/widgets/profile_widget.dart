import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String? fileImage;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    this.fileImage,
    this.isEdit = false,
    required this.onClicked,
    File? imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: !isEdit ? Container() : buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    //final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(color: Colors.transparent, child: getImage(fileImage)),
    );
  }

  Widget getImage(String? picture) {
    if (picture == null)
      return Image(
        image: AssetImage('assets/imgs/no-image.png'),
        fit: BoxFit.contain,
        width: 128,
        height: 128,
      );

    if (picture.startsWith('http'))
      return FadeInImage(
        image: NetworkImage(picture),
        placeholder: AssetImage('assets/imgs/jar-loading.png'),
        fit: BoxFit.contain,
        width: 128,
        height: 128,
      );

    return Image.file(
      File(picture),
      fit: BoxFit.contain,
      width: 128,
      height: 128,
    );
  }

  Widget buildEditIcon(Color color) => GestureDetector(
        onTap: onClicked,
        child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
            color: color,
            all: 8,
            child: Icon(
              isEdit ? Icons.add_a_photo : Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
