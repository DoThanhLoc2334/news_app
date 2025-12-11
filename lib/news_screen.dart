import 'package:flutter/material.dart';
import 'modelArticle.dart';
import 'api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<ModelArticle> _articles = [];
  bool _loading = true;
  String? _error;

  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await ApiService.fetchArticles();
      setState(() {
        _articles = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _loadArticles,
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : _error != null
            ? Center(child: Text("Error: $_error"))
            : _articles.isEmpty
            ? Center(child: Text("Don't have news"))
            : ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),

                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
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
                      title: Text(article.title, maxLines: 2),
                      subtitle: Text(
                        article.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
