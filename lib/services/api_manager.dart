import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/newsinfo.dart';

class ApiManager with ChangeNotifier {
  List<Article> _news = [];
  List<Article> _searchedNews = [];
  String _currentCategory = 'general';

  List<Article> get news {
    return [..._news];
  }

  List<Article> get searchedNews {
    return [..._searchedNews];
  }

  String get currentCategory {
    return _currentCategory;
  }

  setCategory(String category) {
    _currentCategory = category;
    notifyListeners();
  }

  List<String> category = [
    'General',
    'Business',
    'Bntertainment',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];
  //method to fetch and set data
  Future<List<Article>> getNews() async {
    var url =
        'http://newsapi.org/v2/top-headlines?country=in&category=$_currentCategory&apiKey=1440ae58ae3e4387855021f640272584';
    var client = http.Client();
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var newsModel = Welcome.fromJson(jsonMap);
        final List<Article> loadednews = newsModel.articles;
        _news = loadednews;
      }
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
    print('Inside fetch method : ');
    return _news;
  }

  //method to fetch by keyword
  Future<List<Article>> fetchByKeyWord(String keyword) async {
    final customUrl =
        'https://newsapi.org/v2/top-headlines?q=$keyword&apiKey=1440ae58ae3e4387855021f640272584';

    var client = http.Client();
    try {
      var response = await client.get(customUrl);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var newsModel = Welcome.fromJson(jsonMap);
        final List<Article> loadednews = newsModel.articles;
        _searchedNews = loadednews;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return _searchedNews;
  }

  //find news by category
  Article findByIndex(int index) {
    return _news[index];
  }
}
