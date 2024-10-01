class Category {
  final String id;
  final String name;
  final String img;

  Category({
    required this.id,
    required this.name,
    required this.img,
  });
}

List<Category> categories = [
  Category(
      id: '1', name: 'accessories', img: 'assets/images/cats/accessories.png'),
  Category(id: '2', name: 'dress', img: 'assets/images/cats/dress.png'),
  Category(id: '3', name: 'shoes', img: 'assets/images/cats/shoe.png'),
  Category(id: '4', name: 'formal', img: 'assets/images/cats/formal.png'),
  Category(id: '5', name: 'informal', img: 'assets/images/cats/informal.png'),
  Category(id: '6', name: 'jeans', img: 'assets/images/cats/jeans.png'),
  Category(id: '7', name: 't-shirts', img: 'assets/images/cats/t-shirt.png'),
  Category(id: '8', name: 'Kids', img: 'assets/images/cats/t-shirt.png'),
];
