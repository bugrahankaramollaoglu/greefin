/*import 'package:flutter/material.dart';

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
*/
/*import 'package:flutter/material.dart';

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
*/
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
        backgroundColor: Colors.green, // Yeşil renk tonu
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildTipCard('Save energy by turning off unnecessary lights and using energy-efficient LED bulbs.', Colors.lightGreen),
          _buildTipCard('Separate recyclable materials such as plastic, paper, and glass.', Colors.greenAccent),
          _buildTipCard('Conserve water by turning off the tap while brushing your teeth and taking shorter showers.', Colors.teal),
          _buildTipCard('Consider renewable energy sources like solar panels or wind turbines for your home.', Colors.lightGreenAccent),
          _buildTipCard('Reduce your carbon footprint by using public transportation instead of driving.', Colors.cyan),
          _buildTipCard('Use a bicycle for short distances to stay healthy and reduce carbon emissions.', Colors.lightBlue),
          _buildTipCard('Share rides to reduce fuel costs and carbon emissions.', Colors.green),
          _buildTipCard('Opt for electric or hybrid vehicles.', Colors.lime),
          _buildTipCard('Enhance home insulation to save energy.', Colors.green.shade300),
          _buildTipCard('Reduce energy consumption with energy-efficient appliances.', Colors.green.shade200),
          _buildTipCard('Opt for renewable energy plans from your electricity provider.', Colors.green.shade100),
          _buildTipCard('Choose locally produced foods to reduce transportation-related carbon emissions.', Colors.lightGreen.shade200),
          _buildTipCard('Lower your carbon footprint by consuming seasonal products.', Colors.lightGreen.shade100),
          _buildTipCard('Shift towards plant-based diets to reduce your carbon footprint.', Colors.lightGreenAccent.shade100),
          _buildTipCard('Reduce food waste by planning meals and utilizing leftovers.', Colors.green.shade50),
          _buildTipCard('Compost organic waste to recycle nutrients.', Colors.green.shade400),
          _buildTipCard('Prefer reusable products over single-use plastic items.', Colors.green.shade500),
          _buildTipCard('Use reusable bags instead of plastic bags when shopping.', Colors.green.shade600),
          _buildTipCard('Install water-saving faucet heads and showerheads.', Colors.green.shade700),
          _buildTipCard('Extend the lifespan of clothes by donating or recycling them.', Colors.green.shade800),
          _buildTipCard('Lower your carbon footprint by reducing meat consumption.', Colors.green.shade900),
          _buildTipCard('Embrace sustainable fashion by minimizing clothing purchases.', Colors.lightGreen.shade300),
          _buildTipCard('Contribute to local production by growing your own food.', Colors.lightGreen.shade400),
          _buildTipCard('Reduce carbon emissions by buying second-hand products.', Colors.lightGreen.shade500),
          _buildTipCard('Reduce your digital carbon footprint by cleaning up emails.', Colors.lightGreen.shade600),
          _buildTipCard('Lower energy consumption by watching videos in lower resolution.', Colors.lightGreen.shade700),
          _buildTipCard('Save energy by washing clothes in cold water.', Colors.lightGreen.shade800),
          _buildTipCard('Air-dry clothes instead of using a dryer.', Colors.lightGreen.shade900),
          _buildTipCard('Recycle office supplies to support environmental efforts.', Colors.greenAccent.shade100),
          _buildTipCard('Offset your carbon footprint through donations to climate projects when traveling.', Colors.greenAccent.shade200),
          _buildTipCard('Choose sustainable tourism options.', Colors.lightGreen.shade300),
          _buildTipCard('Travel using hybrid or electric vehicles.', Colors.greenAccent.shade400),
          _buildTipCard('Use climate-friendly transportation options.', Colors.lightGreen.shade500),
          _buildTipCard('Reduce air pollution by driving hybrid or electric vehicles.', Colors.lightGreen.shade600),
          _buildTipCard('Monitor home energy consumption to achieve savings.', Colors.greenAccent.shade700),
          _buildTipCard('Use solar energy to meet your hot water needs.', Colors.lightGreen.shade800),
          _buildTipCard('Track home energy usage for efficiency gains.', Colors.lightGreen.shade900),
          _buildTipCard('Reduce heat loss with energy-efficient windows.', Colors.teal.shade100),
          _buildTipCard('Use smart thermostats in buildings for energy savings.', Colors.teal.shade200),
          _buildTipCard('Increase natural light to save energy.', Colors.teal.shade300),
          _buildTipCard('Save water with low-flow toilets.', Colors.teal.shade400),
          _buildTipCard('Implement sustainable practices in your workplace.', Colors.teal.shade500),
          _buildTipCard('Educate employees on sustainability practices.', Colors.teal.shade600),
          _buildTipCard('Reduce waste by participating in recycling programs.', Colors.teal.shade700),
          _buildTipCard('Use energy-efficient devices in your workplace.', Colors.teal.shade800),
          _buildTipCard('Lower energy consumption by watching videos in lower resolution.', Colors.teal.shade900),
          _buildTipCard('Reduce paper waste by using digital documents.', Colors.cyan.shade100),
          _buildTipCard('Reduce textile waste by embracing slow fashion.', Colors.cyan.shade200),
          _buildTipCard('Lower your carbon footprint by traveling less.', Colors.cyan.shade300),
          _buildTipCard('Conserve water and energy to protect natural resources.', Colors.cyan.shade400),
        ],
      ),
    );
  }

  Widget _buildTipCard(String tip, Color backgroundColor) {
    return Card(
      color: backgroundColor, // Arka plan rengi
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          tip,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black, // Yazı rengi
          ),
        ),
      ),
    );
  }
}
