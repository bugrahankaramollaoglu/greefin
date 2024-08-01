import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Tips',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TipsPage()),
            );
          }
        },
      ),
    );
  }
}

class TipsPage extends StatelessWidget {
  final List<String> tips = [
    'Save energy by turning off unnecessary lights and using energy-efficient LED bulbs.',
    'Separate recyclable materials such as plastic, paper, and glass.',
    'Conserve water by turning off the tap while brushing your teeth and taking shorter showers.',
    'Consider renewable energy sources like solar panels or wind turbines for your home.',
    'Reduce your carbon footprint by using public transportation instead of driving.',
    'Use a bicycle for short distances to stay healthy and reduce carbon emissions.',
    'Share rides to reduce fuel costs and carbon emissions.',
    'Opt for electric or hybrid vehicles.',
    'Enhance home insulation to save energy.',
    'Reduce energy consumption with energy-efficient appliances.',
    'Opt for renewable energy plans from your electricity provider.',
    'Choose locally produced foods to reduce transportation-related carbon emissions.',
    'Lower your carbon footprint by consuming seasonal products.',
    'Shift towards plant-based diets to reduce your carbon footprint.',
    'Reduce food waste by planning meals and utilizing leftovers.',
    'Compost organic waste to recycle nutrients.',
    'Prefer reusable products over single-use plastic items.',
    'Use reusable bags instead of plastic bags when shopping.',
    'Install water-saving faucet heads and showerheads.',
    'Extend the lifespan of clothes by donating or recycling them.',
    'Lower your carbon footprint by reducing meat consumption.',
    'Embrace sustainable fashion by minimizing clothing purchases.',
    'Contribute to local production by growing your own food.',
    'Reduce carbon emissions by buying second-hand products.',
    'Reduce your digital carbon footprint by cleaning up emails.',
    'Lower energy consumption by watching videos in lower resolution.',
    'Save energy by washing clothes in cold water.',
    'Air-dry clothes instead of using a dryer.',
    'Recycle office supplies to support environmental efforts.',
    'Offset your carbon footprint through donations to climate projects when traveling.',
    'Choose sustainable tourism options.',
    'Travel using hybrid or electric vehicles.',
    'Use climate-friendly transportation options.',
    'Reduce air pollution by driving hybrid or electric vehicles.',
    'Monitor home energy consumption to achieve savings.',
    'Use solar energy to meet your hot water needs.',
    'Track home energy usage for efficiency gains.',
    'Reduce heat loss with energy-efficient windows.',
    'Use smart thermostats in buildings for energy savings.',
    'Increase natural light to save energy.',
    'Save water with low-flow toilets.',
    'Implement sustainable practices in your workplace.',
    'Educate employees on sustainability practices.',
    'Reduce waste by participating in recycling programs.',
    'Use energy-efficient devices in your workplace.',
    'Lower energy consumption by watching videos in lower resolution.',
    'Reduce paper waste by using digital documents.',
    'Reduce textile waste by embracing slow fashion.',
    'Lower your carbon footprint by traveling less.',
    'Conserve water and energy to protect natural resources.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                tips[index],
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
