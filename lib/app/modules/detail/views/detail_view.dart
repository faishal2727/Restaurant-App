import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';

class DetailView extends StatelessWidget {
  final String restaurantId;

  DetailView({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.fetchRestaurantDetail(restaurantId);
      },
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: Obx(
              () => FlexibleSpaceBar(
                title: Text(
                  controller.restaurantDetail.value?.restaurant.name ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${controller.restaurantDetail.value?.restaurant.pictureId}',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.error.value
                      ? Center(child: Text(controller.errorMessage.value))
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.restaurantDetail.value?.restaurant.name ?? '',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Icon(Icons.location_on),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        controller.restaurantDetail.value?.restaurant.city ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      controller.restaurantDetail.value?.restaurant.address ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        controller.restaurantDetail.value?.restaurant.rating.toString() ?? '',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  controller.restaurantDetail.value?.restaurant.description ?? '',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Categories:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Wrap(
                                        spacing: 8,
                                        children: controller.restaurantDetail.value?.restaurant.categories
                                                .map((category) => Chip(
                                                      backgroundColor: Colors.amber,
                                                      label: Text(category.name),
                                                    ))
                                                .toList() ??
                                            [],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Menus:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ExpansionTile(
                                            title: Text(
                                              'Foods',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            children: [
                                              Column(
                                                children: controller.restaurantDetail.value!.restaurant.menus.foods
                                                    .map((food) => ListTile(
                                                          title: Text(food.name),
                                                        ))
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: Text(
                                              'Drinks',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            children: [
                                              Column(
                                                children: controller.restaurantDetail.value!.restaurant.menus.drinks
                                                    .map((drink) => ListTile(
                                                          title: Text(drink.name),
                                                        ))
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
