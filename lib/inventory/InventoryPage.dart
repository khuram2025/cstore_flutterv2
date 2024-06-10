import 'package:flutter/material.dart';
import '../accounts/customAppbar.dart';
import '../accounts/customedrawer.dart';
import '../home/home_page.dart';

class InventoryPage extends StatelessWidget {
  final String businessName;

  InventoryPage({required this.businessName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Inventory',
      ),
      drawer: CustomDrawer(businessName: businessName),
      body: Center(
        child: Text('Inventory Page Content'),
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
        currentIndex: 3,
        selectedItemColor: Color(0xFF0DA487),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(businessName: businessName)),
          );
        },
      ),
    );
  }
}
