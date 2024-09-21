import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:campus_haat/models/product_model.dart';

class ApiService {
  final String url;
  ApiService({required this.url});

  Future<ProductsListResponse?> fetchProducts() async {
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "creator": {
        "id": "6873",
        "creatorId": "298",
        "APIKey": "8e6b42f1644ecb13",
        "applicationId": "1",
        "createDate": "2024-09-15 13:15:45.8"
      },
      "campusId": "7740",
      "productCategory": {
        "selectedFilter": {"categoryId": "15"}
      },
      "productSection": "0",
      "loadType": 8,
      "limit": 10,
      "start": 0
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody is Map<String, dynamic>) {
          return ProductsListResponse.fromJson(jsonBody);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
