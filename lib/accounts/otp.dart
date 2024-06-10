import 'package:cstore_flutter/accounts/otpReset.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RequestOTPPage extends StatefulWidget {
  @override
  _RequestOTPPageState createState() => _RequestOTPPageState();
}

class _RequestOTPPageState extends State<RequestOTPPage> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  Future<void> _requestOTP() async {
    setState(() {
      _isLoading = true;
      _message = null;
    });

    final response = await http.post(
      Uri.parse('http://app.channab.com/accounts/api/request-otp/'), // Change to your API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': _mobileController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        _message = 'OTP sent to your mobile number';
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordPage(mobile: _mobileController.text),
        ),
      );
    } else {
      setState(() {
        _message = 'Failed to send OTP';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _requestOTP,
                child: Text('Request OTP'),
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
