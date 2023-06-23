import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../detail/views/detail_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: mediaQueryHeight * 0.11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi, faishal2727",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Find your Restaurant now"),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        // Tambahkan fungsi yang ingin dijalankan saat ikon settings diklik
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari Restaurant...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                controller.searchRestaurants(value);
              },
            ),
            SizedBox(height: 8),
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Lottie.asset('assets/lottie/waiting_load.json',
                          width: 250, height: 250),
                    );
                  } else if (controller.restaurants.isEmpty) {
                    return Center(
                      child: Lottie.asset('assets/lottie/not_result.json',
                          width: 250, height: 250),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = controller.restaurants[index];
                        return InkWell(
                          onTap: () {
                            print('ID: ${restaurant.id}');
                            Get.to(
                                () => DetailView(restaurantId: restaurant.id));
                          },
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      restaurant.pictureUrl,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          restaurant.name,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                            ),
                                            Text(
                                              restaurant.city,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
