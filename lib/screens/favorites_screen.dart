import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.favorites),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<List<Map<String, String>>>(
          valueListenable: FavoritesService.favorites,
          builder: (context, favs, _) {
            if (favs.isEmpty) {
              return Center(
                child: Text(t.noFavoritesYet),
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