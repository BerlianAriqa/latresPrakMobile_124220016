import 'package:flutter/material.dart';
import 'package:latresmobile/pages/data.dart';

class FavoritePage extends StatelessWidget {
  final List<Results>? favoriteNews;
  final List<Results>? favoriteBlogs;
  final List<Results>? favoriteReports;
  final Function(Results) onRemoveFavorite;

  const FavoritePage({
    Key? key,
    required this.favoriteNews,
    required this.favoriteBlogs,
    required this.favoriteReports,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.lens), text: 'News'),
              Tab(icon: Icon(Icons.block), text: 'Blogs'),
              Tab(icon: Icon(Icons.report), text: 'Reports'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FavoriteItemsView(
              favoriteItems: favoriteNews ?? [],
              onRemoveFavorite: onRemoveFavorite,
            ),
            FavoriteItemsView(
              favoriteItems: favoriteBlogs ?? [],
              onRemoveFavorite: onRemoveFavorite,
            ),
            FavoriteItemsView(
              favoriteItems: favoriteReports ?? [],
              onRemoveFavorite: onRemoveFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteItemsView extends StatelessWidget {
  final List<Results> favoriteItems;
  final Function(Results) onRemoveFavorite;

  const FavoriteItemsView({
    Key? key,
    required this.favoriteItems,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoriteItems[index];
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              // Navigate to the item details page
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: item.imageUrl != null
                        ? Image.network(
                            item.imageUrl!,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          )
                        : const Icon(Icons.image),
                  ),
                  const Spacer(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title ?? ''),
                      IconButton(
                        onPressed: () {
                          onRemoveFavorite(item);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}