import 'package:flutter/material.dart';

class SummaryBox extends StatelessWidget {
  final double totalGive;
  final double totalGet;

  SummaryBox({required this.totalGive, required this.totalGet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SummaryTile(
            amount: 'Rs. ${totalGive.toStringAsFixed(2)}',
            description: 'You will give',
            color: totalGive < 0 ? Colors.red : Colors.green,
          ),
          SummaryTile(
            amount: 'Rs. ${totalGet.toStringAsFixed(2)}',
            description: 'You will get',
            color: totalGet < 0 ? Colors.red : Colors.green,
          ),
          GestureDetector(
            onTap: () {
              // Handle view report action
            },
            child: Text(
              'View Report',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String amount;
  final String description;
  final Color color;

  SummaryTile({required this.amount, required this.description, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(description),
      ],
    );
  }
}
