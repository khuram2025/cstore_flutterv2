import 'package:cstore_flutter/accounts/transactionList.dart';
import 'package:flutter/material.dart';

import 'SearchFilterSortRow.dart';
import 'models.dart';


class PurchasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SearchFilterSortRow(),
            Expanded(
              child: TransactionList(transactions: [
                Transaction(
                  title: 'Supplier A',
                  subtitle: 'Purchase 10 Mar',
                  amount: '₹4,200',
                  iconColor: Colors.blue,
                ),
                Transaction(
                  title: 'Supplier B',
                  subtitle: 'Purchase 9 Mar',
                  amount: '₹3,150',
                  iconColor: Colors.blue,
                ),
                Transaction(
                  title: 'Supplier C',
                  subtitle: 'Purchase 8 Mar',
                  amount: '₹2,700',
                  iconColor: Colors.blue,
                ),
              ]),
            ),
          ],
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the end
            children: [
              FloatingActionButton.extended(
                onPressed: () {},
                label: Text('PAYMENT OUT'),
                icon: Icon(Icons.payment),
                backgroundColor: Colors.blue,
              ),
              SizedBox(width: 16),
              FloatingActionButton.extended(
                onPressed: () {},
                label: Text('ADD PURCHASE'),
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}