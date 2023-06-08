import 'package:get/get.dart';
import '../../../data/api/api_service.dart';
import '../../../data/model/restaurant.dart';

class HomeController extends GetxController {
  final ApiService apiService = Get.find();
  final restaurants = <Restaurant>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    try {
      isLoading.value = true;
      final List<dynamic> response = await apiService.fetchData();
      restaurants.value =
          response.map((json) => Restaurant.fromJson(json)).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchRestaurants(String query) async {
    try {
      isLoading.value = true;
      final List<dynamic> response = await apiService.searchRestaurants(query);
      restaurants.value =
          response.map((json) => Restaurant.fromJson(json)).toList();
    } finally {
      isLoading.value = false;
    }
  }
}
