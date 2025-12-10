import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelArticle.dart';

class ApiService {
  static const String apiUrl = "https://newapi.org/v2/top-headlines?country=us&apiKey=apiKey=YOUR_API_KEY";

    static Future<List<ModelArticle>> fetchArticles() async{
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);

      List articlesJson = jsonData["articles"] ?? [];
      return articlesJson
          .map((item) => ModelArticle.fromJson(item))
          .toList();
    } else {
      throw Exception("Failed to load news");
    }
  }
}