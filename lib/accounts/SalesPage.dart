import 'package:flutter/material.dart';


class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        ListTile(
          leading: Icon(Icons.receipt, color: Colors.yellow),
          title: Text('Raaghav Verma'),
          subtitle: Text('Sale 12 Mar'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('₹1,304', style: TextStyle(color: Colors.black)),
              Text('Paid', style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.payment, color: Colors.green),
          title: Text('Vyom Kushwaha'),
          subtitle: Text('Payment In 12 Mar'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('₹889', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.request_quote, color: Colors.grey),
          title: Text('Dhruva V Raghavan'),
          subtitle: Text('Quotation 11 Mar'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('₹13,302', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.receipt, color: Colors.yellow),
          title: Text('Party name'),
          subtitle: Text('Sale 11 Mar'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('₹6,553', style: TextStyle(color: Colors.black)),
              Text('Partially paid', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
      ],
    );
  }
}