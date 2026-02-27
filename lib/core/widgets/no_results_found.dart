import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final TextStyle? textStyle;

  const NoResultsFound({
    super.key,
    this.message = "No Results Found",
    this.icon = Icons.search_off,
    this.iconSize = 60,
    this.iconColor = Colors.grey,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          const SizedBox(height: 12),
          Text(
            message,
            style:
                textStyle ??
                TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
