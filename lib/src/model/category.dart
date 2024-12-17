class Category {
  final String title;
  final List<Subcategory> subcategories;

  Category({required this.title, required this.subcategories});
}

class Subcategory {
  final String imageUrl;
  final String label;

  Subcategory({required this.imageUrl, required this.label});
}
