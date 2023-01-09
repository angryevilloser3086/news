import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/news_headline.dart';

class HomeProvider extends ChangeNotifier {
  Client client = Client();
  static const baseURL =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=d9b5a73c07e94e84b769b39a793a9ba7";
  News? topNews;

  Future<News?> getTopHeadLine() async {
    // getToken(token);
    var response = await client.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
    

      
        topNews = News.fromJson(jsonDecode(response.body));
        notifyListeners();
     
      return topNews;
    } else {
      throw "unable to fetch news";
    }
  }
}
