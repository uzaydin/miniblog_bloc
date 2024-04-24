import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/articles/article_state.dart';

import 'package:miniblog/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  // Initial State => Başlangıç state'i
  ArticleBloc({required this.articleRepository}) : super(ArticlesNotLoaded()) {
    on<FetchArticles>(_fetchArticles);
    on<CreateBlogEvent>(_postBlog);
  }

  void _fetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final blogs = await articleRepository.fetchAll();
      emit(ArticlesLoaded(blogs: blogs));
    } catch (e) {
      emit(ArticlesLoadFail());
    }
  }

  void _postBlog(CreateBlogEvent event, Emitter<ArticleState> emit) async {
    emit(BlogLoading());
    try {
      final blog = await articleRepository.createBlog(event.blog, event.file!);
      emit(BlogSuccess(blog: blog));
    } catch (e) {
      emit(BlogError());
    }
  }
}
