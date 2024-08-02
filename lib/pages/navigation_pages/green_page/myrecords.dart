import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'myrecordsresult.dart';

class MyRecords extends StatelessWidget {
  const MyRecords({super.key});

  Future<void> _deleteAllRecords(BuildContext context) async {
    final collection =
        FirebaseFirestore.instance.collection('carbon_footprints');

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete All'),
          content: const Text('Are you sure you want to delete all records?'),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // Fetch all records
      var records = await collection.get();
      for (var record in records.docs) {
        await record.reference.delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All records deleted.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Records',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () => _deleteAllRecords(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: const Text(
                'Delete All',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carbon_footprints')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var records = snapshot.data!.docs;

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              var record = records[index];
              var timestamp = (record['timestamp'] as Timestamp).toDate();
              var formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);

              // Cast all numeric values to double
              double electricity = (record['electricity'] as num).toDouble();
              double transport = (record['transport'] as num).toDouble();
              double meat = (record['meat'] as num).toDouble();
              double water = (record['water'] as num).toDouble();
              double fruit = (record['fruit'] as num).toDouble();
              double heating = (record['heating'] as num).toDouble();
              double totalCO2 = (record['total_co2'] as num).toDouble();

              Map<String, double> dataMap = {
                "Electricity": electricity,
                "Transport": transport,
                "Meat": meat,
                "Water": water,
                "Fruit": fruit,
                "Heating": heating,
              };

              return Dismissible(
                key: Key(record.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red.shade200,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete this record?'),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  record.reference.delete();
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green.shade300, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.green.shade50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      'Total CO2: ${totalCO2.toStringAsFixed(2)} ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Date: $formattedDate',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyRecordsResultPage(
                            carbonFootprint: totalCO2,
                            status: totalCO2 > 1500
                                ? 'High Carbon Footprint'
                                : 'Low Carbon Footprint',
                            dataMap: dataMap,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
