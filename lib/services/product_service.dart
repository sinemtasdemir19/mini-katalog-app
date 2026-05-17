import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductService {

  Future<List<ProductModel>>
  getProducts() async {

    final response =
    await http.get(

      Uri.parse(
        "https://wantapi.com/products.php",
      ),
    );

    if(response.statusCode
        == 200){

      final jsonData =
      jsonDecode(
        response.body,
      );

      final List productList =
      jsonData["data"];

      return productList

          .map(

            (item)=>

            ProductModel
                .fromJson(
              item,
            ),

      )

          .toList();

    }

    else{

      throw Exception(
        "Ürünler alınamadı",
      );

    }
  }
}