import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;
  final Color textColor;

  InfoBox({required this.title, required this.value, required this.borderColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,  // Increased width of the box
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Transparent white background
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,  // Smaller title text
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,  // Bigger amount text
            ),
          ),
        ],
      ),
    );
  }
}