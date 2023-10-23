import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating});

  final double rating;
  
  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star,
        color: Colors.grey[400],
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(Icons.star_half, color: Colors.amber);
    } else {
      icon = const Icon(
        Icons.star,
        color: Colors.amber,
      );
    }
    return InkResponse(
      onTap: (){},
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List<Widget>.generate(5, (index) => buildStar(context, index)));
  }
}
