import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordPage extends StatefulWidget {
  final String mobile;

  ResetPasswordPage({required this.mobile});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
      _message = null;
    });

    final response = await http.post(
      Uri.parse('http://app.channab.com/accounts/api/verify-otp/'), // Change to your API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': widget.mobile,
        'otp': _otpController.text,
        'new_password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        _message = 'Password reset successful';
      });
    } else {
      setState(() {
        _message = 'Failed to reset password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mobile Number: ${widget.mobile}'),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_message!),
              ),
          ],
        ),
      ),
    );
  }
}
