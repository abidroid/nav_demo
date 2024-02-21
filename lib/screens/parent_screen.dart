import 'package:flutter/material.dart';
import 'package:nav_demo/screens/about_us.dart';
import 'package:nav_demo/screens/contact_us.dart';
import 'package:nav_demo/screens/geocode_city_screen.dart';
import 'package:nav_demo/screens/home_page.dart';
import 'package:nav_demo/screens/maps_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                child: Column(
              children: [
                Icon(
                  Icons.ac_unit,
                  size: 80,
                ),
                Text('Navigation Drawer'),
              ],
            )),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Maps'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const MapScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Geo Coding'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const GeocodeCityScreen();
                }));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Navigation Demo'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contact us',
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [HomePage(), AboutUs(), ContactUs()],
      ),
    );
  }
}
