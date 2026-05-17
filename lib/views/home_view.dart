import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_view.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../components/product_card.dart';
import 'cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int selectedIndex = 0;

  List<ProductModel> products = [];

  List<ProductModel> filteredProducts = [];

  bool isLoading = true;

  final ProductService productService =
      ProductService();

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("isLoggedIn");
    await prefs.remove("email");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    loadProducts();
  }

  Future<void> loadProducts()
  async {

    products = await productService.getProducts();

    setState(() {
      filteredProducts = products;
      isLoading = false;
    });
  }
  void searchProduct(String value) {
    setState(() {
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(
              value.toLowerCase(),
            );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(
        0xFFE6E6FA,
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "S-Katalog",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor:
        Colors.white,
        elevation: 0,
      ),
      
      body:
      isLoading
      ? const Center(
      child:
      CircularProgressIndicator(),
      )
      : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.circular(
                20,
              ),
              child: Image.network(
                "https://wantapi.com/assets/banner.png",
                height: 140,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: searchProduct,
              decoration:
              InputDecoration(
                hintText:
                "Ürün ara...",
                prefixIcon:
                const Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor:
                Colors.white,
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child:
              GridView.builder(
                itemCount:
                filteredProducts.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder:
                (context,index){
                  return ProductCard(
                    product:
                    filteredProducts[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
      BottomNavigationBar(

        currentIndex:
        selectedIndex,

        selectedItemColor:
        const Color(
          0xFFB5A8C4,
        ),

        items: const [

          BottomNavigationBarItem(

            icon: Icon(
              Icons.home,
            ),

            label:
            "Home",
          ),

          BottomNavigationBarItem(

            icon: Icon(
              Icons.shopping_cart,
            ),

            label:
            "Cart",
          ),
        ],

        onTap: (index){
        setState(() {
        selectedIndex = index;
        });
        if(index == 1){
        Navigator.push(
        context,
        MaterialPageRoute(
        builder:
        (context)=>
        const CartView(),
        ),
        );
        }
        },
      ),
    );
  }
}