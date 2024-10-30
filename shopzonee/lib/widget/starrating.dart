import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopzonee/utils/colors.dart';


class StarRating extends StatelessWidget {
  final int rating;
  final int noOfRatings;

  const StarRating({
    Key? key,
    required this.rating,
    required this.noOfRatings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Star icons
        Row(
          children: List.generate(5, (index) {
            return Icon(
              size: 26,
              index < rating
                  ? Icons.star
                  : Icons.star_border, // Full or empty star
              color: index < rating ? kGreen : kSecondary,
            );
          }),
        ),

        // Add some spacing between the stars and the text
        const SizedBox(width: 8),

        // Text showing the number of ratings
        Text(
          '($noOfRatings)',
          style: TextStyle(
            fontSize: 12.sp,
            color: kDarkgrey, // Adjust text color if needed
          ),
        ),
      ],
    );
  }
}
