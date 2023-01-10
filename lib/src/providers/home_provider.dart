import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/news_headline.dart';

class HomeProvider extends ChangeNotifier {
  Client client = Client();
  bool isLoading = true;
  String countryCode = '';
  static const apiKey = "d9b5a73c07e94e84b769b39a793a9ba7";
  static const baseURL = "https://newsapi.org/v2/top-headlines?country=";
  News? topNews;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  get user => _auth.currentUser;

  Future<void> getTopHeadLine() async {
    // getToken(token);
    if (countryCode.isEmpty) {
      fetchConfig();
    } else {
      var response =
          await client.get(Uri.parse("$baseURL$countryCode&apiKey=$apiKey"));
      if (response.statusCode == 200) {
        isLoading = true;
        topNews = News.fromJson(jsonDecode(response.body));
        isLoading = false;
        notifyListeners();

        
      } else {
        throw "unable to fetch news";
      }
    }
  }

  Future<void> fetchConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 2),
        minimumFetchInterval: const Duration(microseconds: 10),
      ),
    );
    await remoteConfig.fetchAndActivate();
    countryCode = remoteConfig.getValue("Country").asString();
    getTopHeadLine();
    notifyListeners();
    
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
