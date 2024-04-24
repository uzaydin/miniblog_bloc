import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/articles/article_state.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
      if (state is ArticlesNotLoaded) {
        context.read<ArticleBloc>().add(FetchArticles());
        return const Center(
          child: Text("Yazıların yükleme işlemi başlamadı.."),
        );
      }

      if (state is ArticlesLoading) {
        return const CircularProgressIndicator();
      }

      if (state is ArticlesLoadFail) {
        return const Center(
          child: Text("Blogların yüklenmesinde hata oluştu"),
        );
      }

      if (state is ArticlesLoaded) {
        return ListView.builder(
          itemCount: state.blogs.length,
          itemBuilder: (context, index) {
            final blog = state.blogs[index];
            return Card(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(blog.title ?? "Başlık yok",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  if (blog.thumbnail != null) Image.network(blog.thumbnail!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(blog.content ?? "İçerik yok"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(blog.author ?? "Yazar bilinmiyor",
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
            );
          },
        );
      }

      return const Text("Bilinmedik durum..");
    });
  }
}
