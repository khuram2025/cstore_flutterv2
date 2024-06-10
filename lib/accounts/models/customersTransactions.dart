import 'package:flutter/material.dart';


class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String? actionLabel;
  final Color iconColor;
  final VoidCallback onTap;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    this.actionLabel,
    required this.iconColor,
    required this.onTap,
  });
}