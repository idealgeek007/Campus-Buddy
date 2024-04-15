import 'package:flutter/material.dart';

class MyCircularAvatar extends StatelessWidget {
  final String? imageUrl;
  final String defaultImageUrl;

  const MyCircularAvatar({
    Key? key,
    this.imageUrl,
    required this.defaultImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? NetworkImage(imageUrl!)
          : AssetImage(defaultImageUrl) as ImageProvider<Object>,
    );
  }
}
