class MenuItemModel {
  final String image;
  final String menuItem;
  final String price;
  final String description;
  final String restaurantId;

  const MenuItemModel(
      {required this.image,
      required this.menuItem,
      required this.description,
      required this.price,
      required this.restaurantId});

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
        image: map['image'],
        menuItem: map['menuItem'],
        description: map['description'],
        price: map['price'],
        restaurantId: map['restaurantId']);
  }
}
