import 'package:miniblog/models/blog.dart';

abstract class ArticleState {}

class ArticlesNotLoaded extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Blog> blogs;

  ArticlesLoaded({required this.blogs});
}

class ArticlesLoading extends ArticleState {}

class ArticlesLoadFail extends ArticleState {}

// POST




class BlogNotLoaded extends ArticleState{}

class BlogLoading extends ArticleState {}

class BlogSuccess extends ArticleState {
  final Blog blog;

  BlogSuccess({required this.blog});
}

class BlogError extends ArticleState {}
