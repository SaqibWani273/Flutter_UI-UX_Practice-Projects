class DashboardModels {
  final List<FeaturedService> featuredServices;
  final TodaySpecial todaySpecial;
  final List<CategoryModel> categories;
  final List<HairSalon> hairSalons;

  DashboardModels({
    required this.featuredServices,
    required this.todaySpecial,
    required this.categories,
    required this.hairSalons,
  });
}

class FeaturedService {
  final String discountPrice;
  final String originalPrice;
  final String image;
  final String name;
  FeaturedService({
    required this.discountPrice,
    required this.originalPrice,
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discounted_price': discountPrice,
      'original_price': originalPrice,
      'image': image,
      'name': name,
    };
  }

  factory FeaturedService.fromMap(Map<String, dynamic> map) {
    return FeaturedService(
      discountPrice: map['discounted_price'],
      originalPrice: map['original_price'],
      image: map['image'],
      name: map['name'],
    );
  }
}

class TodaySpecial {
  final String text;
  final int discount;
  final List<String> images;
  TodaySpecial({
    required this.text,
    required this.discount,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'discount': discount,
      'images': images,
    };
  }

  factory TodaySpecial.fromMap(Map<String, dynamic> map) {
    return TodaySpecial(
      text: map['text'] as String,
      discount: map['discount'] as int,
      images: List<String>.from((map['images'])),
    );
  }
}

class CategoryModel {
  final String name;
  final String image;
  CategoryModel({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}

class HairSalon {
  final String name;
  final String address;
  final String image;
  final String distance;
  final double rating;
  final bool isVerified;
  final int totalReviews;
  HairSalon({
    required this.name,
    required this.address,
    required this.image,
    required this.distance,
    required this.rating,
    required this.isVerified,
    required this.totalReviews,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'image': image,
      'distance': distance,
      'rating': rating,
      'is_verified': isVerified,
      'total_reviews': totalReviews,
    };
  }

  factory HairSalon.fromMap(Map<String, dynamic> map) {
    return HairSalon(
      name: map['name'],
      address: map['address'],
      image: map['image'],
      distance: map['distance'],
      rating: map['rating'] as double,
      isVerified: map['is_verified'] as bool,
      totalReviews: map['total_reviews'] as int,
    );
  }

  @override
  String toString() {
    return 'HairSalon(name: $name, address: $address, image: $image, distance: $distance, rating: $rating, isVerified: $isVerified, totalReviews: $totalReviews)';
  }
}
