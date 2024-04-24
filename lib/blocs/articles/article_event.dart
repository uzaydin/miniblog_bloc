import 'package:image_picker/image_picker.dart';
import 'package:miniblog/models/blog.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class CreateBlogEvent extends ArticleEvent {
  final Blog blog;
  XFile? file; //olarak dene!

  CreateBlogEvent(this.blog, this.file);
}
