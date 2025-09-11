import 'package:get/get.dart';
import 'package:quiz_app/app/data/productModel.dart';
import 'package:quiz_app/app/modules/service.dart';

class HomeController extends GetxController {
  // Reactive state variables
  var products = <Product>[].obs;
  var isLoadingProducts = false.obs;
  var errorMessage = "".obs;

  final Service service = Service();

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // load on start
  }

  Future<void> fetchProducts() async {
    try {
      isLoadingProducts(true);
      final data = await service.getProducts();
      products.value = data.map<Product>((e) => Product.fromJson(e)).toList();

      print("✅ Products loaded: ${products.length}");
    } catch (e) {
      errorMessage.value = e.toString();
      print("❌ Error: $e");
    } finally {
      isLoadingProducts(false);
    }
  }
}
