class RestaurantPostResult {
  RestaurantPostResult({
    required this.error,
    required this.massage,
    required this.customerReviews,
  });

  bool? error;
  String? massage;
  List<CustomerReviews>? customerReviews;

  factory RestaurantPostResult.fromJson(Map<String, dynamic> json) =>
      RestaurantPostResult(
          error: json['error'],
          massage: json['message'],
          customerReviews: List<CustomerReviews>.from(
              ((json['customerReviews']) as List)
                  .map((x) => CustomerReviews.fromJson(x))
                  .where(
                    (restaurants) =>
                        restaurants.name != null &&
                        restaurants.review != null &&
                        restaurants.date != null,
                  )));
}

class CustomerReviews {
  String? name;
  String? review;
  String? date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
        name: json['name'],
        review: json['review'],
        date: json['date'],
      );
}
