import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../accounts/customAppbar.dart';
import '../accounts/customedrawer.dart';
import '../widgets/api_util.dart';
import '../widgets/bottom_navigation.dart';

class CreateCustomerPage extends StatefulWidget {
  final String businessName;

  CreateCustomerPage({required this.businessName});

  @override
  _CreateCustomerPageState createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends State<CreateCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  int _selectedIndex = 1;
  String? _errorMessage;

  Future<void> _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final headers = await ApiUtil.getHeaders();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? businessId = prefs.getInt('business_id'); // Retrieve the saved business ID

      if (businessId == null) {
        setState(() {
          _errorMessage = 'Business ID not found';
        });
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiUtil.BASE_URL}/customers/api/customer-create-link/'),
        headers: headers,
        body: json.encode({
          'name': _nameController.text,
          'phone': _mobileController.text,
          'business_id': businessId.toString(), // Ensure business ID is sent as a string
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Customer created successfully
        Navigator.pop(context, true); // Return to the previous screen with success
      } else if (response.statusCode == 400) {
        // Handle customer already exists error
        final responseData = json.decode(response.body);
        setState(() {
          _errorMessage = responseData['message'];
        });
      } else {
        // Handle other errors
        setState(() {
          _errorMessage = 'Failed to create customer: ${response.body}';
        });
      }
    }
  }

  void _cancel() {
    Navigator.pop(context, false); // Return to the previous screen without success
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF0DA487)),
      borderRadius: BorderRadius.circular(8.0),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Customer',
      ),
      drawer: CustomDrawer(businessName: widget.businessName),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the customer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address (Optional)',
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _balanceController,
                decoration: InputDecoration(
                  labelText: 'Opening Balance (Optional)',
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _paymentDateController,
                decoration: InputDecoration(
                  labelText: 'Payment Date (Optional)',
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 32.0),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveCustomer,
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFF0DA487), backgroundColor: Colors.white, // Text color
                        side: BorderSide(color: Color(0xFF0DA487)), // Border color
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _cancel,
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey, backgroundColor: Colors.white, // Text color white
                        side: BorderSide(color: Colors.grey), // Border color grey
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: _selectedIndex,
        businessName: widget.businessName,
      ),
    );
  }
}
