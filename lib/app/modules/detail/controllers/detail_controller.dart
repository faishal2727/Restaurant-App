import 'package:get/get.dart';
import '../../../data/api/api_service.dart';
import '../../../data/model/detail_restaurant.dart';
import 'package:get/get.dart';


class DetailController extends GetxController {
  var isLoading = true.obs;
  var error = false.obs;
  var errorMessage = ''.obs;
  var restaurantDetail = Rx<RestaurantDetail?>(null);

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      isLoading(true);
      final apiService = ApiService();
      final response = await apiService.getRestaurantDetail(id);
      restaurantDetail.value = response;
    } catch (e) {
      error(true);
      errorMessage.value = 'Failed to load restaurant detail';
    } finally {
      isLoading(false);
    }
  }
}






