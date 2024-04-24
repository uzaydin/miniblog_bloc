import 'package:image_picker/image_picker.dart';
import 'package:miniblog/models/blog.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticleRepository {
  Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

  Future<List<Blog>> fetchAll() async {
    final response = await http.get(url);

    final List body = json.decode(response.body);

    return body.map((element) => Blog.fromJson(element)).toList();
  }

  Future<Blog> createBlog(Blog blog, XFile file) async {
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(blog.toJson()));

    if (response.statusCode == 201) {
      return Blog.fromJson(json.decode(response.body));
    } else {
      throw Exception("Hata");
    }
  }
}
