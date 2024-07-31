import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:text_divider/text_divider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

User? getCurrentUser() {
  return _auth.currentUser;
}

Future<List<DocumentSnapshot>> getFilteredData(String userEmail) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('purchases')
      .where('user', isEqualTo: userEmail)
      .orderBy('date', descending: true)
      .limit(5)
      .get();

  return querySnapshot.docs;
}

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = getCurrentUser();
    final String userEmail = user?.email ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 90,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Birikim Hedefim",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 160,
                decoration: BoxDecoration(
                  color: MyColors().color4,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width * 0.9 - 290) / 2,
                top: (160 - 60) / 3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: MyColors().color6,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.wallet,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$ 6,356.73',
                            style: TextStyle(
                              color: MyColors().color6,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 2,
                      height: 80,
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 150,
                      height: 100,
                      color: MyColors().color4,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: MyColors().color6,
                                ),
                                Text(
                                  '\$ 17,000.00',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: MyColors().color6,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 20, 0, 20),
                                  child: Container(
                                    width: 120,
                                    height: 2,
                                    color: Colors.white,
                                    child: Center(
                                      child: Container(
                                        width: 120,
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: MyColors().color6,
                                ),
                                Text(
                                  '\$ 2,540.25',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: MyColors().color6,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          TextDivider.horizontal(
            text: const Text(
              'Purchases History',
              style: TextStyle(),
            ),
            color: Colors.black87,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: getFilteredData(userEmail),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found.'));
                } else {
                  return ListView(
                    children: snapshot.data!.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 26.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: MyColors().color10,
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                          leading: Icon(Icons.arrow_forward_ios),
                          title: Text(data['name']),
                          subtitle: Text(
                            '\$${data['price']}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
