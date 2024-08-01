import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     /*  appBar: AppBar(
        centerTitle: true,
        title: Text('STATS'),
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Container(
            decoration: BoxDecoration(
              color: MyColors().color10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              iconSize: 20,
              icon: Icon(Icons.arrow_back_rounded),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ),
      ), */
      body: Center(child: Text('STATS page')),
    );
  }
}
