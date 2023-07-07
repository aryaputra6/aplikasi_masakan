import 'package:flutter/material.dart';
import 'meal.dart';
import 'meal_api.dart';

class MealDetailPage extends StatefulWidget {
  final String mealId;

  const MealDetailPage({super.key, required this.mealId});

  @override
  _MealDetailPageState createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  late Future<Meal> _mealFuture;

  @override
  void initState() {
    super.initState();
    _mealFuture = MealApi.getMealDetails(widget.mealId);
  } // Path: lib\detail_screen.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Makanan'),
      ),
      body: Center(
        child: FutureBuilder<Meal>(
          future: _mealFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final meal = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    meal.thumbnailUrl, //untuk mengambil gambar dari internet
                    width: 300, //untuk mengatur lebar gambar
                    height: 300, //untuk mengatur tinggi gambar
                  ),
                  const SizedBox(
                      height: 16), //untuk mengatur jarak antar gambar
                  Text(
                    meal.name, //untuk menampilkan nama makanan
                    style: const TextStyle(
                      fontSize: 20, //untuk mengatur ukuran font
                      fontWeight:
                          FontWeight.bold, //untuk mengatur ketebalan font
                    ),
                  ),
                  const SizedBox(
                      height: 8), //untuk mengatur jarak antar nama makanan
                  Text(
                    meal.category, //untuk menampilkan kategori makanan
                    style: const TextStyle(
                        fontSize: 16), //untuk mengatur ukuran font
                  ),
                  const SizedBox(
                      height: 16), //untuk mengatur jarak antar kategori makanan
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal:
                            16), //untuk mengatur jarak antar deskripsi makanan
                    child: Text(
                      meal.instructions, //untuk menampilkan deskripsi makanan
                      textAlign: TextAlign.center, //untuk mengatur posisi teks
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
