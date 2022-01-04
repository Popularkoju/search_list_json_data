import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:searchingjson/entities/note.dart';
import 'package:http/http.dart' as http;

class PostService{

  Future<List<Post>> fetchPost(context) async {
    int aStatusCode = 0;
    List<Post> posts = [];
    String URL ="https://jsonplaceholder.typicode.com/posts";
    while (aStatusCode != 200) {  /// fetch data until status code 200
      try {
        final response = await http.get(Uri.parse(URL));
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<Post> posts =
          values.map((e) => Post.fromJson(e)).toList();
          return posts;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No Internet Connection", textAlign: TextAlign.center),
        ));
        throw Exception("failed to load post");
      } on TimeoutException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text("Sorry, Failed to Load Data", textAlign: TextAlign.center),
        ));
        throw Exception("failed to load post");
      }
    }
    return posts;
  }
}