class Product {
  final String id;
  final String title;
  final String info;
  final String imageUrl;
  final int price;
  final int originalPrice;
  final int off;
  final int quantity;
  final String sellerName;

  Product({
    required this.off,
    required this.originalPrice,
    required this.id,
    required this.title,
    required this.info,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.sellerName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      originalPrice: json['productPricing']['price'],
      off: json['productPricing']['off'],
      title: json['title'] ?? '',
      info: json['info'] ?? '',
      imageUrl: json['media']['mediaUrls'] != null &&
              json['media']['mediaUrls'].isNotEmpty
          ? json['media']['mediaUrls'][0]
          : '',
      price: json['productPricing']['price'],
      quantity: json['productQuantity'] ?? 0,
      sellerName: json['productSoldBy'] != null
          ? json['productSoldBy']['creatorName']
          : 'Unknown',
    );
  }
}

class BaseResponse {
  final int count;
  final String message;
  final String statusCode;

  BaseResponse({
    required this.count,
    required this.message,
    required this.statusCode,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      count: json['count'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}

class ProductsListResponse {
  final BaseResponse baseResponse;
  final List<Product> products;

  ProductsListResponse({
    required this.baseResponse,
    required this.products,
  });

  factory ProductsListResponse.fromJson(Map<String, dynamic> json) {
    // Get the list of products inside the 'productsList' array
    List<Product> productList = [];
    if (json['productsList'] != null && json['productsList'].isNotEmpty) {
      var productData = json['productsList'][0]['products'] as List;
      // Parsing each product inside the list
      productList = productData.map((productJson) {
        return Product.fromJson(productJson as Map<String, dynamic>);
      }).toList();
    }

    return ProductsListResponse(
      baseResponse: BaseResponse.fromJson(json['baseResponse']),
      products: productList,
    );
  }
}
