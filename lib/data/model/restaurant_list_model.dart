class RestaurantResult {
  RestaurantResult({
    required this.error,
    required this.massage,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String massage;
  int count;
  List<Restaurants> restaurants;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
          error: json['error'],
          massage: json['message'],
          count: json['count'],
          restaurants: List<Restaurants>.from((json['restaurants'] as List)
              .map((x) => Restaurants.fromJson(x))
              .where(
                (restaurants) =>
                    restaurants.id != null &&
                    restaurants.name != null &&
                    restaurants.description != null &&
                    restaurants.pictureId != null &&
                    restaurants.city != null &&
                    restaurants.ratings != null,
              )));
}

class Restaurants {
  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.ratings,
  });
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  num? ratings;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        ratings: json['rating'],
      );
}



// class RestaurantDetailResult {
  
// }


