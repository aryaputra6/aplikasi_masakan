import 'package:aplikasi_masakan/meal_api.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'meal.dart';

void main() {
  runApp(const MyApp()); //untuk menjalankan aplikasi
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masakan', //untuk menampilkan judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, //untuk mengatur warna aplikasi
      ),
      home: const MealListPage(),
    );
  }
} //untuk menampilkan judul aplikasi

class MealListPage extends StatefulWidget {
  const MealListPage({super.key});

  @override
  _MealListPageState createState() => _MealListPageState();
} //untuk menampilkan judul aplikasi

class _MealListPageState extends State<MealListPage> {
  late Future<List<Meal>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = MealApi.getMeals();
  } //untuk menampilkan judul aplikasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Makanan'), //untuk menampilkan judul aplikasi
      ),
      body: Center(
        child: FutureBuilder<List<Meal>>(
          future: _mealsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final meals = snapshot.data!;
              return ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      tileColor: Colors.grey[200],
                      leading: Image.network(
                        meal.thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                      title: Text(meal.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MealDetailPage(mealId: meal.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
