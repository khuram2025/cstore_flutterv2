import 'package:flutter/material.dart';
import '../accounts/customAppbar.dart';
import '../accounts/customedrawer.dart';
import '../widgets/bottom_navigation.dart';

class MorePage extends StatelessWidget {
  final String businessName;
  final int selectedIndex;

  MorePage({
    required this.businessName,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'More',
      ),
      drawer: CustomDrawer(businessName: businessName),
      body: Center(
        child: Text('More Page Content'),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: selectedIndex,
        businessName: businessName,
      ),
    );
  }
}
