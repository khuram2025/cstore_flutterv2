import 'package:flutter/material.dart';
import '../accounts/customAppbar.dart';
import '../accounts/customedrawer.dart';
import '../accounts/customerPage.dart';
import '../widgets/bottom_navigation.dart';
import 'CreateCustomerPage.dart';

class PartiesPage extends StatefulWidget {
  final String businessName;

  PartiesPage({required this.businessName});

  @override
  _PartiesPageState createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: 'Parties',
      ),
      drawer: CustomDrawer(businessName: widget.businessName),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Color(0xFF0DA487),
            labelColor: Color(0xFF0DA487),
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'Customers'),
              Tab(text: 'Suppliers'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CustomersTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateCustomerPage(businessName: widget.businessName),
            ),
          );
        },
        label: Text('ADD CUSTOMER'),
        icon: Icon(Icons.add),
        backgroundColor: Color(0xFF0DA487),  // Change button color to 0xFF0DA487
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: _selectedIndex,
        businessName: widget.businessName,
      ),
    );
  }
}
