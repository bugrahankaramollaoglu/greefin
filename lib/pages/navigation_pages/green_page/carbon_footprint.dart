import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'result.dart';
import 'green_page.dart';

class CarbonFootprint extends StatefulWidget {
  const CarbonFootprint({super.key});

  @override
  State<CarbonFootprint> createState() => _CarbonFootprintState();
}

class _CarbonFootprintState extends State<CarbonFootprint> {
  final TextEditingController _electricityController = TextEditingController();
  final TextEditingController _transportController = TextEditingController();
  final TextEditingController _meatController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _fruitController = TextEditingController();
  final TextEditingController _gasController = TextEditingController();
  final TextEditingController _coalController = TextEditingController();

  double _carbonFootprint = 0.0;
  String _status = '';
  String _transportMode = 'Walking';
  String _heatingType = 'Do not use';

  double electricity = 0.0;
  double transport = 0.0;
  double meat = 0.0;
  double water = 0.0;
  double fruit = 0.0;
  double heating = 0.0;

  void _calculateCarbonFootprint() {
    setState(() {
      electricity = (double.tryParse(_electricityController.text) ?? 0.0) * 0.707;
      transport = 0.0;

      switch (_transportMode) {
        case 'Car':
          transport = (double.tryParse(_transportController.text) ?? 0.0) * 0.271;
          break;
        case 'Motorcycle':
          transport = (double.tryParse(_transportController.text) ?? 0.0) * 0.162;
          break;
        case 'Bicycle':
        case 'Walking':
        case 'Not Using Vehicle':
        default:
          transport = 0.0;
          break;
      }

      meat = (double.tryParse(_meatController.text) ?? 0.0) * 27;
      water = (double.tryParse(_waterController.text) ?? 0.0) * 0.298;
      fruit = (double.tryParse(_fruitController.text) ?? 0.0) * 0.4;
      heating = 0.0;

      if (_heatingType == 'Natural Gas') {
        heating = (double.tryParse(_gasController.text) ?? 0.0) * 1.88;
      } else if (_heatingType == 'Coal') {
        heating = (double.tryParse(_coalController.text) ?? 0.0) * 2.414;
      }

      _carbonFootprint = electricity + transport + meat + water + fruit + heating;
      _status = _carbonFootprint > 1500 ? 'High Carbon Footprint' : 'Low Carbon Footprint';

      FirebaseFirestore.instance.collection('carbon_footprints').add({
        'total_co2': _carbonFootprint,
        'electricity': electricity,
        'transport': transport,
        'meat': meat,
        'water': water,
        'fruit': fruit,
        'heating': heating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            carbonFootprint: _carbonFootprint,
            status: _status,
            dataMap: {
              "Electricity": electricity,
              "Transport": transport,
              "Meat": meat,
              "Water": water,
              "Fruit": fruit,
              "Heating": heating,
            },
          ),
        ),
      ).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => GreenPage()),
              (Route<dynamic> route) => false,
        );
      });
    });
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carbon Footprint',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/carbon.png'),
              const SizedBox(height: 16),
              const Text(
                'Calculate My Carbon Foot Print',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _electricityController,
                decoration: InputDecoration(
                  labelText: 'Electricity Consumption',
                  suffixText: 'kWh',
                  border: _buildBorder(Colors.green),
                  enabledBorder: _buildBorder(Colors.green),
                  focusedBorder: _buildBorder(Colors.green),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _transportMode,
                onChanged: (String? newValue) {
                  setState(() {
                    _transportMode = newValue!;
                  });
                },
                items: <String>[
                  'Walking',
                  'Bicycle',
                  'Car',
                  'Motorcycle',
                  'Not Using Vehicle'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Transportation Mode',
                  border: _buildBorder(Colors.green),
                  enabledBorder: _buildBorder(Colors.green),
                  focusedBorder: _buildBorder(Colors.green),
                ),
              ),
              const SizedBox(height: 8),
              if (_transportMode != 'Not Using Vehicle')
                TextField(
                  controller: _transportController,
                  decoration: InputDecoration(
                    labelText: 'Transport Distance',
                    suffixText: 'km',
                    border: _buildBorder(Colors.green),
                    enabledBorder: _buildBorder(Colors.green),
                    focusedBorder: _buildBorder(Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                ),
              const SizedBox(height: 16),
              const Text(
                'Food Consumption',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _meatController,
                decoration: InputDecoration(
                  labelText: 'Monthly Meat Consumption',
                  suffixText: 'kg',
                  border: _buildBorder(Colors.green),
                  enabledBorder: _buildBorder(Colors.green),
                  focusedBorder: _buildBorder(Colors.green),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _waterController,
                decoration: InputDecoration(
                  labelText: 'Monthly Water Consumption',
                  suffixText: 'm³',
                  border: _buildBorder(Colors.green),
                  enabledBorder: _buildBorder(Colors.green),
                  focusedBorder: _buildBorder(Colors.green),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _fruitController,
                decoration: InputDecoration(
                  labelText: 'Monthly Fruit and Vegetable Consumption',
                  suffixText: 'kg',
                  border: _buildBorder(Colors.green),
                  enabledBorder: _buildBorder(Colors.green),
                  focusedBorder: _buildBorder(Colors.green),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const Text(
                'Heating Consumption',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: _heatingType,
                onChanged: (String? newValue) {
                  setState(() {
                    _heatingType = newValue!;
                  });
                },
                items: <String>['Natural Gas', 'Coal', 'Do not use']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Heating Type',
                  border: _buildBorder(Colors.green),
                  enabledBorder: _buildBorder(Colors.green),
                  focusedBorder: _buildBorder(Colors.green),
                ),
              ),
              const SizedBox(height: 8),
              if (_heatingType == 'Natural Gas')
                TextField(
                  controller: _gasController,
                  decoration: InputDecoration(
                    labelText: 'Natural Gas Consumption',
                    suffixText: 'm³',
                    border: _buildBorder(Colors.green),
                    enabledBorder: _buildBorder(Colors.green),
                    focusedBorder: _buildBorder(Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                ),
              if (_heatingType == 'Coal')
                TextField(
                  controller: _coalController,
                  decoration: InputDecoration(
                    labelText: 'Coal Consumption',
                    suffixText: 'kg',
                    border: _buildBorder(Colors.green),
                    enabledBorder: _buildBorder(Colors.green),
                    focusedBorder: _buildBorder(Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateCarbonFootprint,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
