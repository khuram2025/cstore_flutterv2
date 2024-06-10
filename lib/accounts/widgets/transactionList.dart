import 'package:flutter/material.dart';
import '../models/customersTransactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final amountString = transaction.amount.replaceAll('Rs.', '').replaceAll(',', '').trim();
        final amount = double.tryParse(amountString) ?? 0.0;
        final amountColor = amount < 0 ? Colors.red : Colors.green;

        return ListTile(
          onTap: transaction.onTap,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          leading: CircleAvatar(
            backgroundColor: transaction.iconColor,
            child: Text(
              transaction.title[0],
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(transaction.title),
          subtitle: Text(transaction.subtitle),
          trailing: Container(
            constraints: BoxConstraints(maxHeight: 48), // Constrain the height of the trailing widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rs. ${transaction.amount}',
                  style: TextStyle(
                    color: amountColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (transaction.actionLabel != null)
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        // Handle action
                      },
                      child: Text(
                        transaction.actionLabel!,
                        style: TextStyle(
                          color: transaction.iconColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
