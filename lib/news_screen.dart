import 'package:flutter/material.dart';
import 'modelArticle.dart';
import 'api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News"), centerTitle: true),
      body: FutureBuilder<List<ModelArticle>>(
        future: ApiService.fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error load data"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Don't have news"));
          }

          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: article.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    width: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image),
                  )
                      : Icon(Icons.image_not_supported),
                  title: Text(article.title, maxLines: 2,),
                  subtitle: Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
              );
            },
          );
        },
      ),
    );
  }
}