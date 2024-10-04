import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFA259FF),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 14.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
      currentIndex: currentIndex,
      onTap: (index) {
        // Navigate based on the selected tab index
        switch (index) {
          case 0:
            // Navigate to Dashboard
            Navigator.pushNamed(context, '/dashboard');
            break;
          case 1:
            // Navigate to Add Product
            Navigator.pushNamed(context, '/add-product');
            break;
          case 2:
            // Navigate to Profile
            Navigator.pushNamed(context, '/profile');
            break;
          default:
            Navigator.pushNamed(context, '/dashboard');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(7.0),
            child: Icon(Icons.dashboard_outlined),
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(5.5),
            child: Icon(
              Icons.add_circle_outline_sharp,
              size: 28.0, // Enlarged the icon
            ),
          ),
          label: 'Add Product',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(7.0),
            child: Icon(Icons.person_outlined),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
