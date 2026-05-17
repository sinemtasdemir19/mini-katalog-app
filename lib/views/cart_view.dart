import 'package:flutter/material.dart';

import 'home_view.dart';
import 'detail_view.dart';
import '../data/cart_data.dart';
import '../models/product_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double getTotalPrice() {
    double total = 0;

    for (var product in cartItems) {
      String cleanPrice = product.price.replaceAll("\$", "");
      total += double.parse(cleanPrice);
    }

    return total;
  }

  List<ProductModel> getUniqueProducts() {
    List<ProductModel> uniqueProducts = [];

    for (var product in cartItems) {
      bool alreadyExists =
          uniqueProducts.any((item) => item.id == product.id);

      if (!alreadyExists) {
        uniqueProducts.add(product);
      }
    }

    return uniqueProducts;
  }

  int getProductCount(ProductModel product) {
    return cartItems.where((item) => item.id == product.id).length;
  }

  void increaseProduct(ProductModel product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void decreaseProduct(ProductModel product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  void completeOrder() {
    setState(() {
      cartItems.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Siparişiniz tamamlandı"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uniqueProducts = getUniqueProducts();

    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),

      appBar: AppBar(
        title: const Text("Sepetim"),
        backgroundColor: Colors.white,
      ),

      body: cartItems.isEmpty
          ? const Center(
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
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: uniqueProducts.length,
                    itemBuilder: (context, index) {
                      final product = uniqueProducts[index];
                      final count = getProductCount(product);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailView(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.image,
                              width: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.price),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  decreaseProduct(product);
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                count.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  increaseProduct(product);
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    cartItems.removeWhere(
                                      (item) => item.id == product.id,
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Toplam:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${getTotalPrice().toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB5A8C4),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: completeOrder,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return const Color(0xFF8F7AA8);
                                }
                                return const Color(0xFFB5A8C4);
                              },
                            ),
                            elevation: WidgetStateProperty.resolveWith<double>(
                              (states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return 2;
                                }
                                return 6;
                              },
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Siparişi Tamamla",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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