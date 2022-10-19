class ProductModel {
  num? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as num?;
    title = json['title'] as String?;
    price = json['price'] as num?;
    description = json['description'] as String?;
    category = json['category'] as String?;
    image = json['image'] as String?;
    rating = (json['rating'] as Map<String,dynamic>?) != null ? Rating.fromJson(json['rating'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['price'] = price;
    json['description'] = description;
    json['category'] = category;
    json['image'] = image;
    json['rating'] = rating?.toJson();
    return json;
  }
}

class Rating {
  num? rate;
  num? count;

  Rating({
    this.rate,
    this.count,
  });

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] as num?;
    count = json['count'] as num?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['rate'] = rate;
    json['count'] = count;
    return json;
  }
}