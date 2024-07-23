import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/navigation_pages/add_purchase.dart';
import 'package:greefin/pages/navigation_pages/main_page.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:greefin/pages/login_page.dart';
import 'package:greefin/pages/navigation_pages/profile_page.dart';
import 'package:greefin/pages/navigation_pages/green_page/green_page.dart';
import 'package:greefin/pages/navigation_pages/stats_page.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { main, green, add, stats, profile }

MyColors my_colors = MyColors();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  User? user;
  var _selectedTab = _SelectedTab.main;

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges.listen((User? user) {
      setState(() {
        this.user = user;
      });
      if (user == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _buildBody(),
      ),
      bottomNavigationBar: CrystalNavigationBar(
        duration: const Duration(milliseconds: 500),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        height: 50,
        borderRadius: 15,
        splashBorderRadius: 15,
        // outlineBorderColor: Colors.white,
        indicatorColor: MyColors().color9,
        backgroundColor: Colors.transparent,
        selectedItemColor: MyColors().color9,
        unselectedItemColor: Colors.grey,
        onTap: _handleIndexChanged,
        enablePaddingAnimation: false,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
          ),
          CrystalNavigationBarItem(
            icon: Icons.energy_savings_leaf,
            unselectedIcon: Icons.energy_savings_leaf_outlined,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            unselectedIcon: IconlyLight.plus,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.chart,
            unselectedIcon: IconlyLight.chart,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.profile,
            unselectedIcon: IconlyLight.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedTab) {
      case _SelectedTab.main:
        return const MainPage();
      case _SelectedTab.green:
        return const GreenPage();
      case _SelectedTab.add:
        return const AddPurchase();
      case _SelectedTab.stats:
        return const StatsPage();
      case _SelectedTab.profile:
        return ProfilePage();
    }
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
            width: MediaQuery.of(context).size.width * 0.85, // Küçük şekil genişliği
            height: 40, // Küçük şekil yüksekliği
            decoration: BoxDecoration(
              color: Colors.transparent, // İçini boş bırak
              border: Border.all(color: Colors.black, width: 3), // Siyah kenar
              borderRadius: BorderRadius.circular(30), // Oval köşeler
            ),
          ),
          const SizedBox(height: 20), // Küçük şekil ve büyük şekil arasında boşluk
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9, // Ekranın %90 genişliğinde
                height: 160, // Büyük şekil yüksekliği
                decoration: BoxDecoration(
                  color: Colors.amber, // Arka plan rengi
                  borderRadius: BorderRadius.circular(50), // Oval köşeler
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width * 0.9 - 290) / 2, // Merkezi konumlandırmak için
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
                        border: Border.all(color: Colors.white, width: 2), // Beyaz kenar
                      ),
                      child: Center(
                        child: Icon(
                          Icons.wallet, // Cüzdan simgesi
                          color: Colors.green,
                          size: 40, // İkon boyutu
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Beyaz çizgi ile ikon arasındaki boşluk
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
                    child: Icon(item["icon"], color: Colors.white), // İkon rengi
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
                        const SizedBox(height: 2), // Çizgi ve tutar arasındaki boşluk
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
