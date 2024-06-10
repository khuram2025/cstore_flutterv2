import 'package:flutter/material.dart';

import 'models.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          leading: Icon(Icons.receipt, color: transaction.iconColor),
          title: Text(transaction.title),
          subtitle: Text(transaction.subtitle),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end, // Align trailing content to end
            children: [
              Text(
                transaction.amount,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (transaction.status != null)
                Text(
                  transaction.status!,
                  style: TextStyle(color: transaction.statusColor),
                ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        );
      },
    );
  }
}