class ReviewModel {
  final String restaurantId;
  final String review;
  final double rating;
  final String userName;
  final String userImg;
  final DateTime timestamp = DateTime.now();

  ReviewModel(
      {required this.restaurantId,
      required this.review,
      required this.rating,
      required this.userName,
      required this.userImg});

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      restaurantId: map['restaurantId'],
      review: map['review'],
      rating: map['rating'],
      userName: map['userName'],
      userImg: map['userImg'],
    );
  }
}
