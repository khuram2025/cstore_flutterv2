import 'package:cstore_flutter/parties/partiesPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_transaction_page.dart';
import '../accounts/customAppbar.dart';
import '../accounts/customedrawer.dart';
import '../home/home_page.dart';
import '../bills/BillsPage.dart';
import '../inventory/InventoryPage.dart';
import '../accounts/MorePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/api_util.dart';

class CustomerDetailPage extends StatefulWidget {
  final String businessName;
  final String customerName;
  final String customerMobile;
  final String customerStatus;
  final String customerAmount;
  final int customerAccountId;

  CustomerDetailPage({
    required this.businessName,
    required this.customerName,
    required this.customerMobile,
    required this.customerStatus,
    required this.customerAmount,
    required this.customerAccountId,
  });

  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  int _selectedIndex = 1;
  bool _isLoading = true;
  List<dynamic> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final headers = await ApiUtil.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiUtil.BASE_URL}/customers/api/transactions/${widget.customerAccountId}/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {
        _transactions = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load transactions');
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(businessName: widget.businessName)),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PartiesPage(businessName: widget.businessName)),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BillsPage(businessName: widget.businessName)),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InventoryPage(businessName: widget.businessName)),
          );
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MorePage(
              businessName: widget.businessName,
              selectedIndex: index, // Pass the valid index here
            )),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Customer Details',
      ),
      drawer: CustomDrawer(businessName: widget.businessName),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.customerName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(widget.customerMobile),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.customerAmount,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: widget.customerStatus == 'You will give'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    Text(widget.customerStatus),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView(
                children: [
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('In')),
                      DataColumn(label: Text('Out')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: _transactions.map((transaction) {
                      return DataRow(cells: [
                        DataCell(Text(transaction['date'])),
                        DataCell(transaction['transaction_type'] == 'Take'
                            ? Text('₹${transaction['amount']}')
                            : Text('')),
                        DataCell(transaction['transaction_type'] == 'Given'
                            ? Text('₹${transaction['amount']}')
                            : Text('')),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Handle edit action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.details),
                              onPressed: () {
                                // Handle details action
                              },
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionPage(
                businessName: widget.businessName,
                customerName: widget.customerName,
                customerMobile: widget.customerMobile,
              ),
            ),
          );
        },
        label: Text('ADD TRANSACTION'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Parties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Bills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF0DA487),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
