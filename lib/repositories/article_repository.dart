import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/models/blog.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticleRepository {
  final Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

  Future<List<Blog>> fetchAll() async {
    final response = await http.get(url);

    final List body = json.decode(response.body);

    return body.map((element) => Blog.fromJson(element)).toList();
  }

  Future<Blog> createBlog(
    Blog blog,
    XFile? file,
  ) async {
    var request = http.MultipartRequest('POST', url);

    // Blog verisini String türüne dönüştürüp ekliyoruz
    request.fields.addAll(
        blog.toJson().map((key, value) => MapEntry(key, value.toString())));

    if (file != null) {
      File fileToSend = File(file.path); // XFile'ı File'a dönüştürme
      request.files
          .add(await http.MultipartFile.fromPath('file', fileToSend.path));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return Blog.fromJson(json.decode(response.body));
    } else {
      throw Exception("Hata");
    }
  }
}
