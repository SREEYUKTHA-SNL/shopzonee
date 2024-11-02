import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopzonee/utils/colors.dart';


class StarRatingChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy star rating data
    Map<int, int> starRatings = {
      5: 80,
      4: 12,
      3: 5,
      2: 3,
      1: 0,
    };

    int totalRatings = 83;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(5, (index) {
            int star = 5 - index; // Display stars from 5 to 1
            int count = starRatings[star] ?? 0;
            // Number of ratings for that star
            double percentage = totalRatings > 0
                ? count / totalRatings
                : 0; // Percentage of ratings

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    '${5 - index}',
                    style: TextStyle(color: kSecondary),
                  ),

                  // Star Icon
                  Icon(
                    Icons.star,
                    color: kGreen,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  // Progress Indicator for percentage
                  Expanded(
                    child: LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: Color(0xffEFF0F1),
                      borderRadius: BorderRadius.circular(2.r),
                      color: kGreen, // Change the color of the progress bar
                    ),
                  ),
                  SizedBox(width: 8),
                  // Text showing the count
                  Text('$count%'),
                ],
              ),
            );
          }),
        ),
        Row(
          children: [
            Text(
              '47 Reviews',
              style: TextStyle(
                color: kSecondary,
                fontSize: 12.sp,
              ),
            ),
            Spacer(),
            Text(
              'WRITE A REVIEW',
              style: TextStyle(
                color: kSecondary,
                fontSize: 12.sp,
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined))
          ],
        )
      ],
    );
  }
}
