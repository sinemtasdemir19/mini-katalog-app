import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'home_view.dart';
import 'cart_view.dart';

class DetailView extends StatelessWidget {
  final ProductModel product;

  const DetailView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),

      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.tagline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.price,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFFB5A8C4),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB5A8C4),
                ),
                child: const Text(
                  "Sepete Ekle",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFB5A8C4),
        currentIndex: 0,
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartView(),
              ),
            );
          }
        },
      ),
    );
  }
}