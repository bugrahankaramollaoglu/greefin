import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/model/purchase.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:uuid/uuid.dart';

class AddPurchase extends StatelessWidget {
  const AddPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add Purchase Manually'),
      // ),
      body: AddPurchaseForm(),
    );
  }
}

class AddPurchaseForm extends StatefulWidget {
  @override
  _AddPurchaseFormState createState() => _AddPurchaseFormState();
}

class _AddPurchaseFormState extends State<AddPurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _categories = ['FOOD', 'TRAVEL', 'CLOTHING', 'LEISURE'];

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _savePurchase() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userEmail = user.email ?? 'unknown@example.com';
          String name = _nameController.text;
          DateTime? date = DateTime.tryParse(_dateController.text);
          String category = _categoryController.text;
          double price = double.tryParse(_priceController.text) ?? 0.0;

          Purchase purchase = Purchase(
            user: userEmail,
            name: name,
            date: date,
            category: category,
            price: price,
          );

          FirebaseFirestore.instance
              .collection('purchases')
              .add(purchase.toMap());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase saved!')),
          );

          _nameController.clear();
          _dateController.clear();
          _priceController.clear();
          _categoryController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not logged in')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save purchase')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Validation failed')),
      );
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: MyColors().color7.withOpacity(0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black87),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 150, 50, 50),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration('Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name';
                }
                return null;
              },
            ),
            SizedBox(height: 26),
            TextFormField(
              controller: _dateController,
              decoration: _buildInputDecoration('Date (YYYY-MM-DD)'),
              readOnly: true,
              onTap: _selectDate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the date';
                }
                if (DateTime.tryParse(value) == null) {
                  return 'Please enter a valid date';
                }
                return null;
              },
            ),
            SizedBox(height: 26),
            DropdownButtonFormField<String>(
              value: _categories.first,
              decoration: _buildInputDecoration('Category'),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                _categoryController.text = value ?? _categories.first;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            SizedBox(height: 26),
            TextFormField(
              controller: _priceController,
              decoration: _buildInputDecoration('Price \$'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: ElevatedButton(
                onPressed: _savePurchase,
                child: Text(
                  'Save Purchase',
                  style: TextStyle(
                    color: MyColors().color6,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors().color9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
