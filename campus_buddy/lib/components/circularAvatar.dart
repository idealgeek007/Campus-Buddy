import 'package:flutter/material.dart';

class MyCircularAvatar extends StatelessWidget {
  final String? imageUrl;
  final String defaultImageUrl;
  final double radius;
  const MyCircularAvatar({
    Key? key,
    this.imageUrl,
    required this.radius,
    required this.defaultImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? NetworkImage(imageUrl!)
          : AssetImage(defaultImageUrl) as ImageProvider<Object>,
    );
  }
}
