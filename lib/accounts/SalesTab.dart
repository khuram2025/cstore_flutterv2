import 'package:cstore_flutter/accounts/SearchFilterSortRow.dart';
import 'package:cstore_flutter/accounts/transactionList.dart';
import 'package:flutter/material.dart';


import 'models.dart';

class SalesPage extends StatelessWidget {
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
                  title: 'Raaghav Verma',
                  subtitle: 'Sale 12 Mar',
                  amount: '₹1,304',
                  status: 'Paid',
                  iconColor: Colors.yellow,
                  statusColor: Colors.green,
                ),
                Transaction(
                  title: 'Vyom Kushwaha',
                  subtitle: 'Payment In 12 Mar',
                  amount: '₹889',
                  iconColor: Colors.green,
                ),
                Transaction(
                  title: 'Dhruva V Raghavan',
                  subtitle: 'Quotation 11 Mar',
                  amount: '₹13,302',
                  iconColor: Colors.grey,
                ),
                Transaction(
                  title: 'Party name',
                  subtitle: 'Sale 11 Mar',
                  amount: '₹6,553',
                  status: 'Partially paid',
                  iconColor: Colors.yellow,
                  statusColor: Colors.orange,
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
                label: Text('PAYMENT IN'),
                icon: Icon(Icons.payment),
                backgroundColor: Colors.blue,
              ),
              SizedBox(width: 16),
              FloatingActionButton.extended(
                onPressed: () {},
                label: Text('ADD SALE'),
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