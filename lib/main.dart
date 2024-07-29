import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/firebase/firebase_options.dart';
import 'package:greefin/firebase/firebase_router.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/pages/navigation_pages/add_purchase.dart';
import 'package:greefin/pages/navigation_pages/green_page/carbon_footprint.dart';
import 'package:greefin/pages/navigation_pages/green_page/green_map.dart';
import 'package:greefin/pages/navigation_pages/green_page/green_page.dart';
import 'package:greefin/pages/navigation_pages/main_page.dart';
import 'package:greefin/pages/navigation_pages/profile_page.dart';
import 'package:greefin/pages/navigation_pages/stats_page.dart';
import 'package:greefin/pages/onboarding_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: GreefinApp(),
    ),
  );
}

class GreefinApp extends StatefulWidget {
  const GreefinApp({super.key});

  @override
  State<GreefinApp> createState() => _GreefinAppState();
}

class _GreefinAppState extends State<GreefinApp> {
  bool _isOnboardingCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/main': (context) => const MainPage(),
        '/green': (context) => const GreenPage(),
        '/stats': (context) => const StatsPage(),
        '/profile': (context) => ProfilePage(),
        '/green_map': (context) => const GreenMap(),
        '/carbon_footprint': (context) => const CarbonFootprint(),
        '/add_purchase': (context) => const AddPurchase(),
      },
      home: _isOnboardingCompleted
          ? const FirebaseRouter()
          : const OnboardingPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  List<Map<String, dynamic>> elemanlar = [
    {
      "isim": "Maaş",
      "tarih": "01/07/2024",
      "tutar": 5000.0,
      "icon": Icons.attach_money, // İkonu belirlemek için
      "type": "income" // Gelir türü
    },
    {
      "isim": "Market",
      "tarih": "05/07/2024",
      "tutar": 250.0,
      "icon": Icons.shopping_cart, // İkonu belirlemek için
      "type": "expense" // Gider türü
    },
    {
      "isim": "Ev Kirası",
      "tarih": "01/07/2024",
      "tutar": 1500.0,
      "icon": Icons.home, // İkonu belirlemek için
      "type": "expense" // Gider türü
    },
    {
      "isim": "Ulaşım",
      "tarih": "10/07/2024",
      "tutar": 100.0,
      "icon": Icons.directions_car, // İkonu belirlemek için
      "type": "expense" // Gider türü
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Sayfanın arka plan rengi
      body: Column(
        children: [
          SizedBox(
            height: 90, // Üstte boşluk bırakmak için
          ),
          Align(
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
          const SizedBox(height: 15), // Başlık ve küçük şekil arasında boşluk
          Container(
            width: MediaQuery.of(context).size.width *
                0.85, // Küçük şekil genişliği
            height: 40, // Küçük şekil yüksekliği
            decoration: BoxDecoration(
              color: Colors.transparent, // İçini boş bırak
              border: Border.all(color: Colors.black, width: 3), // Siyah kenar
              borderRadius: BorderRadius.circular(30), // Oval köşeler
            ),
          ),
          const SizedBox(
              height: 20), // Küçük şekil ve büyük şekil arasında boşluk
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // Ekranın %90 genişliğinde
                height: 160, // Büyük şekil yüksekliği
                decoration: BoxDecoration(
                  color: Colors.amber, // Arka plan rengi
                  borderRadius: BorderRadius.circular(50), // Oval köşeler
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width * 0.9 - 290) /
                    2, // Merkezi konumlandırmak için
                top: (160 - 60) / 2, // Yüksekliği ortalamak için
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Çocukların minimum boyutu
                  children: [
                    Container(
                      width: 60, // İkonun genişliği
                      height: 60, // İkonun yüksekliği
                      decoration: BoxDecoration(
                        color: Colors.amber, // İç rengini amber yap
                        shape: BoxShape.circle, // Yuvarlak şekil
                        border: Border.all(
                            color: Colors.white, width: 2), // Beyaz kenar
                      ),
                      child: Center(
                        child: Icon(
                          Icons.wallet, // Cüzdan simgesi
                          color: Colors.green,
                          size: 40, // İkon boyutu
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 20), // Beyaz çizgi ile ikon arasındaki boşluk
                    Container(
                      width: 2, // Beyaz çizginin genişliği
                      height: 80, // Çizgi yüksekliği
                      color: Colors.white, // Çizginin rengi
                      child: Center(
                        child: Container(
                          width: 80, // Yatay çizginin genişliği
                          height: 2, // Yatay çizginin yüksekliği
                          color: Colors.white, // Çizginin rengi
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 0), // Şekil ve liste arasında boşluk
          Expanded(
            child: ListView.separated(
              itemCount: elemanlar.length,
              itemBuilder: (context, index) {
                final item = elemanlar[index];
                final isIncome = item["type"] == "income";
                final sign = isIncome ? "+" : "-";
                final color = isIncome ? Colors.green : Colors.red;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent, // İkon arkaplan rengi
                    child:
                        Icon(item["icon"], color: Colors.white), // İkon rengi
                  ),
                  title: Text(item["isim"]),
                  subtitle: Text('Tarih: ${item["tarih"]}'),
                  trailing: SizedBox(
                    width: 100, // Genişliği sabitlemek için
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '|',
                          style: TextStyle(
                            fontSize: 24, // Çizginin boyutu
                            fontWeight: FontWeight.bold, // Çizginin kalınlığı
                            color: Colors.black, // Çizginin rengi
                          ),
                        ),
                        const SizedBox(
                            height: 2), // Çizgi ve tutar arasındaki boşluk
                        Text(
                          '$sign${item["tutar"].toStringAsFixed(2)} TL',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold, // Tutarın kalınlığı
                          ),
                        ),
                      ],
                    ),
                  ),
                  tileColor: Colors.grey.shade100,
                  onTap: () => print('Eleman: $index'),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 5),
            ),
          ),
        ],
      ),
    );
  }
}
