class Meal {
  final String id; //untuk menampilkan id makanan
  final String name; //untuk menampilkan nama makanan
  final String category; //untuk menampilkan kategori makanan
  final String instructions; //untuk menampilkan deskripsi makanan
  final String thumbnailUrl; //untuk mengambil gambar dari internet

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.thumbnailUrl,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '', // Tambahkan ?? '' untuk menghindari null
      name: json['strMeal'] ?? '',
      category:
          json['strCategory'] ?? '', // Tambahkan ?? '' untuk menghindari null
      instructions: json['strInstructions'] ?? '',
      thumbnailUrl: json['strMealThumb'] ?? '',
    );
  } //untuk membuat factory Meal
}//untuk membuat class Meal
