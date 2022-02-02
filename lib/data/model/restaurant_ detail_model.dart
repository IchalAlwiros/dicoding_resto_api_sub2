class RestaurantDetailResult {
  bool? error;
  String? message;
  Restaurant? restaurant;

  RestaurantDetailResult({this.error, this.message, this.restaurant});

  RestaurantDetailResult.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    return data;
  }
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  num? rating;
  List<Categories>? categories;
  Menus? menus;
  List<CustomerReviews>? customerReviews;

  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.city,
      this.address,
      this.pictureId,
      this.rating,
      this.categories,
      this.menus,
      this.customerReviews});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    pictureId = json['pictureId'];
    rating = json['rating'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((data) {
        categories!.add(new Categories.fromJson(data));
      });
    }
    menus = json['menus'] != null ? new Menus.fromJson(json['menus']) : null;
    if (json['customerReviews'] != null) {
      customerReviews = <CustomerReviews>[];
      json['customerReviews'].forEach((data) {
        customerReviews!.add(new CustomerReviews.fromJson(data));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['city'] = this.city;
    data['address'] = this.address;
    data['pictureId'] = this.pictureId;
    data['rating'] = this.rating;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((data) => data.toJson()).toList();
    }
    if (this.menus != null) {
      data['menus'] = this.menus!.toJson();
    }
    if (this.customerReviews != null) {
      data['customerReviews'] =
          this.customerReviews!.map((data) => data.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Menus {
  List<Foods>? foods;
  List<Foods>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(new Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Foods>[];
      json['drinks'].forEach((v) {
        drinks!.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    if (this.drinks != null) {
      data['drinks'] = this.drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String? name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
  }

class CustomerReviews {
  String? name;
  String? review;
  String? date;

  CustomerReviews({this.name, this.review, this.date});

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['review'] = this.review;
    data['date'] = this.date;
    return data;
  }
}
