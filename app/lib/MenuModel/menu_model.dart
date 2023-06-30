class PizzaDragon {
  final String image;
  final String menuItem;
  final int price;
  final String description;

  const PizzaDragon(
      {required this.image,
      required this.menuItem,
      required this.description,
      required this.price});
}

List<PizzaDragon> pizzaDragonMenu = [
  PizzaDragon(
    image:
        'https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/New-York-Style-Pizza_EXPS_FT20_105578_F_1217_1.jpg',
    menuItem: 'New York Style Pizza',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
    price: 450,
  ),
  PizzaDragon(
    image:
        'https://www.moulinex-me.com/medias/?context=bWFzdGVyfHJvb3R8MTQzNTExfGltYWdlL2pwZWd8aGNlL2hmZC8xNTk2ODYyNTc4NjkxMC5qcGd8MmYwYzQ4YTg0MTgzNmVjYTZkMWZkZWZmMDdlMWFlMjRhOGIxMTQ2MTZkNDk4ZDU3ZjlkNDk2MzMzNDA5OWY3OA',
    menuItem: 'Pepperoni Pizza',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
    price: 450,
  ),
  PizzaDragon(
    image: 'https://www.saveur.com/uploads/2019/07/08/JTPSD2ONPYISBHIP4CJ5HDW55A.jpg?auto=webp&auto=webp&optimize=high&quality=70&width=1440',
    menuItem: 'PIzza Margherita',
    description: 'Freshly baked pizza with tomato sauce, mozzarella cheese, and basil leaves.',
    price: 450,
  ),
];