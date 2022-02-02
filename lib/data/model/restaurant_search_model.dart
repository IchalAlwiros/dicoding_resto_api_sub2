class RestaurantSearchResult {
  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });
  Restaurant? restaurants;
  bool? error;
  num? founded;
  // List<Restaurants> restaurants;

  RestaurantSearchResult.fromJson(Map<String, dynamic> json) {
    restaurants = json['restaurants'] != null
        ? new Restaurant.fromJson(json['restaurants'])
        : null;
    error = json['error'];
    founded = json['founded'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants?.toJson();
    }
    data['error'] = this.error;
    data['founded']= this.founded;
    return data;
  }
}

class Restaurant {
  Restaurant({
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

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    ratings = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pictureId'] = this.pictureId;
    data['city'] = this.city;
    data['rating'] = this.ratings;
    return data;
  }
}
