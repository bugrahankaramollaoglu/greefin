import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greefin/model/purchase.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddManually extends StatelessWidget {
  const AddManually({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Purchase Manually'),
      ),
      body: AddManuallyForm(),
    );
  }
}

class AddManuallyForm extends StatefulWidget {
  @override
  _AddManuallyFormState createState() => _AddManuallyFormState();
}

class _AddManuallyFormState extends State<AddManuallyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _savePurchase() async {
    if (_formKey.currentState!.validate()) {
      try {
        String id = Uuid().v4();
        String name = _nameController.text;
        DateTime? date = DateFormat('yyyy-MM-dd').parse(_dateController.text);
        String category = _selectedCategory!;
        double price = double.parse(_priceController.text);

        Purchase purchase = Purchase(
          id: id,
          name: name,
          date: date,
          category: category,
          price: price,
        );

        print("Saving purchase: ${purchase.toString()}");

        FirebaseFirestore.instance.collection('purchases').add({
          'id': purchase.id,
          'name': purchase.name,
          'date': purchase.date?.toIso8601String(),
          'category': purchase.category,
          'price': purchase.price,
        });

        print("Purchase saved!");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Purchase saved!')),
        );

        _nameController.clear();
        _dateController.clear();
        _priceController.clear();
        setState(() {
          _selectedCategory = null;
        });
      } catch (e) {
        print("Error saving purchase: $e");
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
      fillColor: Colors.green.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              decoration: _buildInputDecoration('Date'),
              readOnly: true,
              onTap: () => _selectDate(context),
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
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: _buildInputDecoration('Category'),
              value: _selectedCategory,
              items: ['FOOD', 'TRAVEL', 'CLOTHING', 'LEISURE']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: _buildInputDecoration('Price'),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePurchase,
              child: Text('Save Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
