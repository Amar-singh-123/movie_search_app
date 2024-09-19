import 'package:flutter/material.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class ProfileCard extends StatelessWidget {
  final double radius;
  final String? image;
  const ProfileCard({super.key, required this.radius, this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child:  Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage( image ?? boyIcon),
        ),
      ),
    );
  }
}
