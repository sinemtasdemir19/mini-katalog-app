import 'package:flutter/material.dart';

import 'home_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),

      appBar: AppBar(
        title: const Text("Sepetim"),
        backgroundColor: Colors.white,
      ),

      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 90,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              "Sepetiniz boş",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Henüz ürün eklenmedi",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFB5A8C4),
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}