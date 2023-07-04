class RewardItem {
  final String name;
  final String description;
  final int points;
  final String image;

  RewardItem({
    required this.name,
    required this.description,
    required this.points,
    required this.image,
  });

  factory RewardItem.fromMap(Map<String, dynamic> map) {
    return RewardItem(
      name: map['name'],
      description: map['description'],
      points: map['points'],
      image: map['image'],
    );
  }
}
