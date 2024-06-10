import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/api_util.dart';

class AddTransactionPage extends StatefulWidget {
  final String businessName;
  final String customerName;
  final String customerMobile;

  AddTransactionPage({
    required this.businessName,
    required this.customerName,
    required this.customerMobile,
  });

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _transactionType = 'Take';
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _addTransaction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? businessId = prefs.getInt('business_id');

      final headers = await ApiUtil.getHeaders();
      final response = await http.post(
        Uri.parse('${ApiUtil.BASE_URL}/customers/api/add-transaction/'),
        headers: headers,
        body: jsonEncode({
          'customer_account': {
            'customer': {
              'name': widget.customerName,
              'phone': widget.customerMobile,
            },
            'business': businessId,
          },
          'date': DateTime.now().toIso8601String().split('T')[0], // Format date as YYYY-MM-DD
          'time': TimeOfDay.now().format(context),
          'amount': _amountController.text,
          'transaction_type': _transactionType,
          'notes': _notesController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          _errorMessage = 'Failed to add transaction: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer: ${widget.customerName}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16.0),
              Text('Mobile: ${widget.customerMobile}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _transactionType,
                decoration: InputDecoration(labelText: 'Transaction Type'),
                items: ['Take', 'Given'].map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _transactionType = newValue!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes (Optional)'),
              ),
              SizedBox(height: 32.0),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addTransaction,
                    child: Text('Add Transaction'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
