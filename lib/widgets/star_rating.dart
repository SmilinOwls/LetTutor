import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, this.onRatingChanged});

  final double rating;
  final void Function(double)? onRatingChanged;

  String getRatingToolTipMessage(int index)  {
    String message;

    switch (index) {
      case 0:
        message = 'terrible';
        break;
      case 1:
        message = 'bad';
        break;
      case 2:
        message = 'normal';
        break;
      case 3:
        message = 'good';
        break;
      case 4:
        message = 'wonderfull';
        break;
      default:
        message = 'wonderfull';
    }

    return message;
  }

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
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1),
      onHover: (value) async {
        if (value && onRatingChanged != null) {
          onRatingChanged!(index + 1);
        }
      },
      child: onRatingChanged == null
          ? icon
          : Tooltip(
              message: getRatingToolTipMessage(index),
              waitDuration: const Duration(milliseconds: 200),
              child: icon,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: onRatingChanged == null
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: List<Widget>.generate(
        5,
        (index) => buildStar(context, index),
      ),
    );
  }
}
