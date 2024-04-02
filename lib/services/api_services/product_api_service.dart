

import 'package:assessment/utils/service_result.dart';
import 'package:dio/dio.dart';

import '../../models/product_model.dart';
class ProductApiService{
   final Dio _dio = Dio();
  Future<ServiceResult<List<Product>?>> fetchProductsFromInternet() async{
try {
      
      final response = await _dio.get('https://www.jsonkeeper.com/b/GCQS');
      
      final productsList = response.data['data']['products'] as List<dynamic>;

      List<Product> products = productsList.map((productJson) {
        return Product.fromJson(productJson);
      }).toList();
      
      return response.statusCode == 200 ? ServiceResult( StatusCode.success, "successfully fetched data", products) : ServiceResult(StatusCode.error, response.statusMessage ?? "", null);

      
    } catch (error) {
      return ServiceResult(StatusCode.failure, error.toString(), null);
    }
  }
}