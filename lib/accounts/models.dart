import 'package:flutter/material.dart';


class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String? status;
  final Color iconColor;
  final Color? statusColor;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    this.status,
    required this.iconColor,
    this.statusColor,
  });
}