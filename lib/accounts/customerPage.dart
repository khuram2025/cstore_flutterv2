import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../parties/customer_detail_page.dart';
import '../accounts/models/customersTransactions.dart';
import '../accounts/widgets/SearchRow.dart';
import '../accounts/widgets/transactionList.dart';
import '../accounts/widgets/SummaryBox.dart';
import '../widgets/api_util.dart';

class CustomersTab extends StatefulWidget {
  @override
  _CustomersTabState createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  double totalGive = 0.0;
  double totalGet = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    final headers = await ApiUtil.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiUtil.BASE_URL}/customers/api/customer-accounts/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['accounts'];
      double give = 0.0;
      double get = 0.0;

      setState(() {
        _transactions = data.map((customer) {
          double balance = double.tryParse(customer['total_balance'].toString()) ?? 0.0;
          if (balance < 0) {
            give += balance;
          } else {
            get += balance;
          }

          return Transaction(
            title: customer['customer_name'],
            subtitle: customer['mobile_number'],
            amount: '${customer['total_balance']}',
            actionLabel: 'REQUEST',
            iconColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerDetailPage(
                    businessName: 'My Business',
                    customerName: customer['customer_name'],
                    customerMobile: customer['mobile_number'],
                    customerStatus: 'You will give',
                    customerAmount: 'Rs.${customer['total_balance']}',
                    customerAccountId: customer['id'], // Pass the correct customer account ID
                  ),
                ),
              );
            },
          );
        }).toList();
        totalGive = give;
        totalGet = get;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load customers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchFilterSortRow(hintText: 'Search Customers'),
        SummaryBox(totalGive: totalGive, totalGet: totalGet),
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : TransactionList(transactions: _transactions),
        ),
      ],
    );
  }
}
