import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restaurant_app/app/data/api/api_service.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put(ApiService()); // Register ApiService
  Get.put(HomeController()); // Register HomeController
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.amber),
        ),
      ),
    ),
  );
}
