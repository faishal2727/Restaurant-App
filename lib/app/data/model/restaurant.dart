import 'detail_restaurant.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureUrl;
  final String city;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.city,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureUrl:
          'https://restaurant-api.dicoding.dev/images/large/${json['pictureId']}',
      city: json['city'],
    );
  }
}

