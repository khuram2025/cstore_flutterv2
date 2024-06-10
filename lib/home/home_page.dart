import 'package:flutter/material.dart';
import '../accounts/purchaseTab.dart';
import '../widgets/bottom_navigation.dart';
import '../accounts/customAppbar.dart';
import '../accounts/customedrawer.dart';
import '../accounts/infoBox.dart';
import '../accounts/SalesPage.dart';

import '../accounts/ExpenseTab.dart';

class HomePage extends StatefulWidget {
  final String businessName;

  HomePage({required this.businessName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Store Name',
      ),
      drawer: CustomDrawer(businessName: widget.businessName),
      body: Container(
        color: Colors.white,  // White background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to start and end
              children: [
                InfoBox(
                  title: 'Sale',
                  value: '1000 PKR',
                  borderColor: Colors.green,
                  textColor: Colors.green,
                ),
                InfoBox(
                  title: 'Purchase',
                  value: '500 PKR',
                  borderColor: Colors.blue,
                  textColor: Colors.blue,
                ),
                InfoBox(
                  title: 'Expenses',
                  value: '200 PKR',
                  borderColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Color(0xFF0DA487),
                    labelColor: Color(0xFF0DA487),
                    labelStyle: TextStyle(
                      fontSize: 16.0,  // Increased font size
                      fontWeight: FontWeight.bold,  // Bold text
                    ),
                    tabs: [
                      Tab(text: 'Sales'),
                      Tab(text: 'Purchase'),
                      Tab(text: 'Expense'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SalesPage(),
                        PurchasePage(),
                        ExpenseTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: _selectedIndex,
        businessName: widget.businessName,
      ),
    );
  }
}
