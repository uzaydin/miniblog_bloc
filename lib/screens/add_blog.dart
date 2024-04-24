import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/articles/article_state.dart';
import 'package:miniblog/models/blog.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();

  String blogTitle = "";
  String blogContent = "";
  XFile? selectedImage;
  String author = "";

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (selectedImage != null) {
        // BLoC event'ini tetikle
        BlocProvider.of<ArticleBloc>(context).add(
          CreateBlogEvent(
              Blog(
                title: blogTitle,
                content: blogContent,
                author: author,
                // thumbnail:
                //     selectedImage, // Blog modelinizde uygun şekilde ayarlamalısınız
              ),
              selectedImage),
        );
      }
    }
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Blog Ekle"),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (selectedImage != null)
                    Image.file(File(selectedImage!.path), height: 250),
                  ElevatedButton(
                      onPressed: _pickImage, child: const Text("Fotoğraf Seç")),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Blog Başlığı Giriniz"),
                    ),
                    onSaved: (newValue) {
                      blogTitle = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Blog başlığı boş olamaz.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Blog İçeriği Giriniz"),
                    ),
                    onSaved: (newValue) {
                      blogContent = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Blog içeriği boş olamaz.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Yazar İsmi Giriniz"),
                    ),
                    onSaved: (newValue) {
                      author = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Yazar ismi boş olamaz.";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: _submit, child: const Text("Kaydet")),
                  if (state is BlogSuccess)
                    const Text("Blog başarıyla kaydedildi."),
                  if (state is BlogError)
                    const Text("Blog kaydedilirken bir hata oluştu."),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// class AddBlog extends StatefulWidget {
//   const AddBlog({super.key});

//   @override
//   _AddBlogState createState() => _AddBlogState();
// }

// class _AddBlogState extends State<AddBlog> {
//   final _formKey = GlobalKey<FormState>();
//   String blogTitle = "";
//   String blogContent = "";
//   XFile? selectedImage;
//   String author = "";

//   void _submit() async {
//     if (selectedImage != null) {
//       Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

//       var request = http.MultipartRequest("POST", url);
//       request.fields["Title"] = blogTitle;
//       request.fields["Content"] = blogContent;
//       request.fields["Author"] = author;

//       final file =
//           await http.MultipartFile.fromPath("File", selectedImage!.path);
//       request.files.add(file);

//       final response = await request.send();

//       if (response.statusCode == 201) {
//         // Başarılı
//         Navigator.pop(context);
//       }
//     }
//   }

//   void _pickImage() async {
//     final imagePicker = ImagePicker();
//     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       selectedImage = file;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Yeni Blog Ekle"),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(children: [
//               if (selectedImage != null)
//                 Image.file(
//                   File(selectedImage!.path),
//                   height: 250,
//                 ),
//               ElevatedButton(
//                   onPressed: () {
//                     _pickImage();
//                   },
//                   child: const Text("Fotoğraf Seç")),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   label: Text("Blog Başlığı Giriniz"),
//                 ),
//                 onSaved: (newValue) {
//                   blogTitle = newValue!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Blog başlığı boş olamaz.";
//                   }
//                   return null; // Diger formlardan ayirmak icin global bir key tanimliyoruz.
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   label: Text("Blog İçeriği Giriniz"),
//                 ),
//                 onSaved: (newValue) {
//                   blogContent = newValue!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Blog içeriği boş olamaz.";
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   label: Text("Yazar İsmi Giriniz"),
//                 ),
//                 onSaved: (newValue) {
//                   author = newValue!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Yazar ismi boş olamaz.";
//                   }
//                   return null;
//                 },
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // onSaved metodlarinin triggerlanmasi
//                       _formKey.currentState!.save();
//                       _submit();
//                     }
//                   },
//                   child: const Text("Kaydet"))
//             ]),
//           ),
//         ));
//   }
// }
