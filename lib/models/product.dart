class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String imageMUrl; // New entry for imageMUrl
  final String category;
  final List<dynamic> colors;
  final String color;
  final List<dynamic> imageUrls;

  // final String colorName;
  // final String colorCode;

  Product(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.imageMUrl, // New entry for imageMUrl
      required this.category,
      required this.colors,
      required this.color,
      required this.imageUrls});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'] as String,
        price: json['price']['value'] as double,
        imageUrl: json['images'][0]['baseUrl'] as String,
        imageMUrl: json['articles'][0]['logoPicture'][0]['baseUrl']
            as String, // Parse imageMUrl
        category: json['categoryName'] as String,
        colors: json['rgbColors'] == null ? [] : json['rgbColors'],
        color: json['articles'][0]['color']['text'],
        imageUrls: json['allArticleBaseImages'] == null
            ? []
            : json['allArticleBaseImages']

        // product['articles'][0]['logoPicture'][0]['baseUrl']
        //     as String,
        );
  }
}
