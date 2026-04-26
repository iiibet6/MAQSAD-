class MenuItem {
  final String name;
  final String price;
  final String image;
  final String category;

  const MenuItem({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}

class Restaurant {
  final String name;
  final String image;
  final String subtitle;
  final String type;
  final String category;
  final List<String> tags;
  final List<String> categories;
  final List<MenuItem> menu;

  const Restaurant({
    required this.name,
    required this.image,
    required this.subtitle,
    required this.type,
    required this.category,
    required this.tags,
    required this.categories,
    required this.menu,
  });
}