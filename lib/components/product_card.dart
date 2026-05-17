import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../views/detail_view.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;

  const ProductCard({

    super.key,

    required this.product,

  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder:
      (context)=>
      DetailView(
      product:
      product,
      ),
      ),
      );
      },

      child: Card(

        elevation: 4,

        shape:
        RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(
            20,
          ),
        ),

        child: Padding(

          padding:
          const EdgeInsets.all(
            12,
          ),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.center,

            children: [

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(

                product.name,

                maxLines: 1,

                overflow:
                TextOverflow
                    .ellipsis,

                textAlign:
                TextAlign.center,

                style:
                const TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 15,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(

                product.tagline,

                maxLines: 2,

                overflow:
                TextOverflow
                    .ellipsis,

                textAlign:
                TextAlign.center,

                style:
                const TextStyle(

                  fontSize: 12,

                  color:
                  Colors.grey,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(

                product.price,

                style:
                const TextStyle(

                  fontSize: 14,

                  fontWeight:
                  FontWeight.w600,

                  color:
                  Color(
                    0xFFB5A8C4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}