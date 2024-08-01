import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyRecordsResultPage extends StatelessWidget {
  final double carbonFootprint;
  final String status;
  final Map<String, double> dataMap;

  const MyRecordsResultPage({
    super.key,
    required this.carbonFootprint,
    required this.status,
    required this.dataMap,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];

    Map<String, double> percentages = dataMap.map((key, value) {
      double total = dataMap.values.reduce((a, b) => a + b);
      return MapEntry(key, (value / total) * 100);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carbon Footprint Result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/my_records'),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Total Carbon Footprint: ${carbonFootprint.toStringAsFixed(2)}  CO2',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: carbonFootprint > 1500 ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: carbonFootprint > 1500 ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            PieChart(
              dataMap: dataMap,
              colorList: colorList,
              chartRadius: MediaQuery.of(context).size.width / 2,
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: false,
              ),
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.bottom,
                showLegends: false,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: percentages.entries.map((entry) {
                int index = percentages.keys.toList().indexOf(entry.key);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: colorList[index],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
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
    );
  }
}
