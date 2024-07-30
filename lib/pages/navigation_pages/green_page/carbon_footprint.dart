import 'package:flutter/material.dart';

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
      electricity = (double.tryParse(_electricityController.text) ?? 0.0) * 0.707; // 1 kWh = 0.707 kg CO2
      transport = 0.0;

      switch (_transportMode) {
        case 'Car':
          transport = (double.tryParse(_transportController.text) ?? 0.0) * 0.271; // 1 km = 0.271 kg CO2
          break;
        case 'Motorcycle':
          transport = (double.tryParse(_transportController.text) ?? 0.0) * 0.162; // 1 km = 0.162 kg CO2
          break;
        case 'Bicycle':
        case 'Walking':
        case 'Not Using Vehicle':
        default:
          transport = 0.0;
          break;
      }

      meat = (double.tryParse(_meatController.text) ?? 0.0) * 27; // 1 kg meat = 27 kg CO2
      water = (double.tryParse(_waterController.text) ?? 0.0) * 0.298; // 1 m³ water = 0.298 kg CO2
      fruit = (double.tryParse(_fruitController.text) ?? 0.0) * 0.4; // 1 kg fruit/veg = 0.4 kg CO2
      heating = 0.0;

      if (_heatingType == 'Natural Gas') {
        heating = (double.tryParse(_gasController.text) ?? 0.0) * 1.88; // 1 m³ gas = 1.88 kg CO2
      } else if (_heatingType == 'Coal') {
        heating = (double.tryParse(_coalController.text) ?? 0.0) * 2.414; // 1 kg coal = 2.414 kg CO2
      }

      _carbonFootprint = electricity + transport + meat + water + fruit + heating;
      _status = _carbonFootprint > 1500 ? 'High Carbon Footprint' : 'Low Carbon Footprint';
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
    Map<String, double> dataMap = {
      "Electricity": electricity,
      "Transport": transport,
      "Meat": meat,
      "Water": water,
      "Fruit": fruit,
      "Heating": heating,
    };

    double total = electricity + transport + meat + water + fruit + heating;

    // Percentage calculations
    Map<String, double> percentages = {
      "Electricity": (electricity / total) * 100,
      "Transport": (transport / total) * 100,
      "Meat": (meat / total) * 100,
      "Water": (water / total) * 100,
      "Fruit": (fruit / total) * 100,
      "Heating": (heating / total) * 100,
    };

    List<Color> colorList = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint'),
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
                items: <String>['Walking', 'Bicycle', 'Car', 'Motorcycle', 'Not Using Vehicle']
                    .map<DropdownMenuItem<String>>((String value) {
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
              if (_heatingType == 'Natural Gas')
                const SizedBox(height: 8),
              if (_heatingType == 'Natural Gas')
                TextField(
                  controller: _gasController,
                  decoration: InputDecoration(
                    labelText: 'Gas Consumption',
                    suffixText: 'm³',
                    border: _buildBorder(Colors.green),
                    enabledBorder: _buildBorder(Colors.green),
                    focusedBorder: _buildBorder(Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                ),
              if (_heatingType == 'Coal')
                const SizedBox(height: 8),
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
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Total Carbon Footprint: ${_carbonFootprint.toStringAsFixed(2)} kg CO2',
                style: TextStyle(
                  fontSize: 18,
                  color: _carbonFootprint > 1500 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _status,
                style: TextStyle(
                  fontSize: 18,
                  color: _carbonFootprint > 1500 ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.center,
                children: [
               /*    PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.ring,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                    baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                    colorList: colorList,
                  ), */
                  const Text(
                    'CO2',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: percentages.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: colorList[percentages.keys.toList().indexOf(entry.key)],
                          margin: const EdgeInsets.only(right: 8),
                        ),
                        Text(
                          '${entry.key}: ${entry.value.toStringAsFixed(2)}%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
