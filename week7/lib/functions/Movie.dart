import 'dart:async';
import 'dart:math';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Movie extends ChangeNotifier {
  Future? _list;

  Future? get list {
    return _list;
  }

  Future getData() async {
    String token =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZDM4MWQ2NTcyMDEwZGZkNzc2MjE3ODY0NmViN2YyNiIsInN1YiI6IjY0NmNiNjAzYTUwNDZlMDEyNDY5NzA5NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.I8mCG2QYqtigfAtXqB7edbKOQ3uTkuJWN9veUBDP4u0";
    Map<String, String> map = {
      "accept": "application/json",
      "Authorization": "Bearer $token"
    };
    Response response = await get(
        Uri.parse(
            "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
    ),
        headers: map);
    var list = jsonDecode(response.body)['results'] as List;
    Random random = new Random();
    return list[random.nextInt(20)];
  }

  void toFuture() {
    _list = getData();
    notifyListeners();
  }

  String getUrl(String url) {
    String urlPart = "https://image.tmdb.org/t/p/original";
    String url1 = "$urlPart$url";
    return url1;
  }
}

class Detail {
  String name;
  String overview;

  Detail(this.name, this.overview);

  factory Detail.fromJson(dynamic json) {
    return Detail(json['name' as String], json['overview'] as String);
  }
}
