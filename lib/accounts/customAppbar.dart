import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF0DA487)),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF0DA487), fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.account_circle, color: Color(0xFF0DA487)),
          onSelected: (String value) {
            // Handle menu selections
            if (value == 'logout') {
              // Handle logout
              Navigator.pushReplacementNamed(context, '/login');
            } else if (value == 'settings') {
              // Navigate to settings
            } else if (value == 'profile') {
              // Navigate to profile
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'profile',
                child: Text('User Name'),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Text('User Settings'),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ];
          },
        ),
      ],
    );
  }
}