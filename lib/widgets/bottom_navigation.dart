import 'package:flutter/material.dart';
import '../accounts/MorePage.dart';
import '../bills/BillsPage.dart';
import '../home/home_page.dart';
import '../parties/partiesPage.dart';
import '../inventory/InventoryPage.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final String businessName;

  BottomNavigationWidget({
    required this.selectedIndex,
    required this.businessName,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xFF0DA487),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,  // Set background color to white
      onTap: (index) {
        if (selectedIndex != index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(businessName: businessName)),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PartiesPage(businessName: businessName)),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BillsPage(businessName: businessName)),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => InventoryPage(businessName: businessName)),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MorePage(
                  businessName: businessName,
                  selectedIndex: index,
                )),
              );
              break;
          }
        }
      },
    );
  }
}
