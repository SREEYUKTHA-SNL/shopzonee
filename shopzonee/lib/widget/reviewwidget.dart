import 'package:flutter/material.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/widget/starchart.dart';
import 'package:shopzonee/widget/starrating.dart';

class ProductDetailsExpansion extends StatelessWidget {
  final String description;
  final double rating;
  final List<Map<String, dynamic>> reviews;

  const ProductDetailsExpansion({
    Key? key,
    required this.description,
    required this.rating,
    required this.reviews,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.only(right: 20, bottom: 15, top: 10),
            iconColor: kDarkgrey,
            title: Text(
              'Description',
              style: TextStyle(
                color: kPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Text(
                description,
                style: TextStyle(
                  color: kDarkgrey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.only(bottom: 15, top: 10),
            iconColor: kDarkgrey,
            title: Text(
              'Reviews',
              style: TextStyle(
                color: kPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          color: kPrimary,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'OUT OF 5',
                        style: TextStyle(
                          color: kSecondary,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      StarRating(rating: rating.round(), noOfRatings: reviews.length),
                    ],
                  ),
                  StarRatingChart(),
                  ...reviews.map((review) => _buildReviewItem(review)).toList(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(review['image']),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['name'],
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      review['stars'],
                      (index) => Icon(
                        Icons.star,
                        color: kGreen,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                review['time'],
                style: TextStyle(
                  color: kSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            review['comment'],
            style: TextStyle(
              color: kDarkgrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
