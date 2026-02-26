import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import 'favorites_screen.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المفضلات'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: FavoritesService.favorites,
          builder: (context, favs, _) {
            if (favs.isEmpty) {
              return const Center(
                child: Text('لا توجد مفضلات حالياً ❤️'),
              );
            }

            return ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final item = favs[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item['title']!),
                );
              },
            );
          },
        ),
      ),
    );
  }
}