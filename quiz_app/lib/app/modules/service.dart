import "dart:convert";
import "package:http/http.dart" as http;

class Service {
  String baseUrl = "https://fakestoreapi.in/api";

  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["products"]; // ✅ Only products array
    } else {
      throw Exception("Failed to load products");
    }
  }
}
