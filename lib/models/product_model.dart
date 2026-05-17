class ProductModel {

  final int id;

  final String name;

  final String tagline;

  final String description;

  final String price;

  final String image;

  ProductModel({

    required this.id,

    required this.name,

    required this.tagline,

    required this.description,

    required this.price,

    required this.image,

  });

  factory ProductModel.fromJson(
      Map<String,dynamic> json){

    return ProductModel(

      id: json["id"],

      name: json["name"],

      tagline:
      json["tagline"],

      description:
      json["description"],

      price:
      json["price"],

      image:
      json["image"],
    );
  }
}