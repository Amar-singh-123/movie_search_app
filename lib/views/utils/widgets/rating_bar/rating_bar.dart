import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({super.key, required this.numberOfRating});
final int numberOfRating;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 10.verticalPadding,
      child: Row(
        children: List.generate(
          numberOfRating,
              (index) {
            return const Icon(
              CupertinoIcons.star_fill,
              color: CupertinoColors.systemYellow,
              size: 20,
            );
          },
        ),
      ),
    );
  }
}
