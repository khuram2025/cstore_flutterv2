import 'package:flutter/material.dart';
import 'accounts/login.dart';
import 'accounts/otp.dart';
import 'accounts/otpReset.dart';
import 'accounts/sighnup.dart';
import 'home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,  // Set the background color to white
        primaryColor: Color(0xFF0DA487),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF0DA487),
          secondary: Colors.deepPurple,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          headline3: TextStyle(color: Colors.black),
          headline4: TextStyle(color: Colors.black),
          headline5: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(businessName: 'Demo Business'),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/request-otp': (context) => RequestOTPPage(),
        '/reset-password': (context) => ResetPasswordPage(mobile: ''),
      },
    );
  }
}

