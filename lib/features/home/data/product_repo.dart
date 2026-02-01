/*import 'package:sonic_app/core/networking/api_service.dart';
import 'package:sonic_app/features/home/data/product_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  // get products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.get('endpoint--->/products');

      // افترض response['data'] عبارة عن List<Map>
      final dataList = response['data'] as List;

      // تحويل كل عنصر لـ ProductModel
      return dataList.map((product) => ProductModel.fromJson(product)).toList();
    } catch (e) {
      print(e.toString());
      return []; // لو فيه مشكلة، رجع ليست فاضية بدل null
    }
  }
}*/
