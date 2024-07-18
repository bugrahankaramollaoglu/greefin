import 'package:flutter/material.dart';
import 'package:greefin/utilities/my_strings.dart';

class GreenPage extends StatelessWidget {
  const GreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            left: 20,
            top: 75,
            child: Text(
              'Carbon Free!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          /*      Positioned(
            top: 60,
            right: 80,
            left: 80,
            child: Image.asset('assets/onb_1.png'),
          ), */
          const Positioned(
            left: 20,
            top: 150,
            child: Text(
              'What is "Carbon Free"?',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
          ),
          const Positioned(
            top: 450,
            left: 130,
            child: Text(
              'Top Features',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 65,
            right: 65,
            child: Container(
              width: 300,
              height: 300,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    top: 20, // adjust the position as needed
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/asd4',
                          width: 75,
                          height: 50,
                        ),
                        const SizedBox(
                            height: 8), // space between image and text
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Calculate  \nFootprint',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20, // adjust the position as needed
                    right: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/asd3',
                          width: 75,
                          height: 50,
                        ),
                        const SizedBox(
                            height: 8), // space between image and text
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'My Records',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20, // adjust the position as needed
                    right: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/asd2',
                          width: 75,
                          height: 50,
                        ),
                        const SizedBox(
                            height: 8), // space between image and text
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Underplanting',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20, // adjust the position as needed
                    left: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/asd',
                          width: 75,
                          height: 50,
                        ),
                        const SizedBox(
                            height: 8), // space between image and text
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/green_map');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Best Route',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // color: Colors.green,
            ),
          ),
          const Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: Text(longText),
          ),
        ],
      ),
    );
  }
}


/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/green_map');
              },
              child: const Text('Map'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/carbon_footprint');
              },
              child: const Text('Carbon footprint'),
            ),
          ],
        ),
      ),
    );
  }
}
 */
