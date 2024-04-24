import 'package:flutter/material.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:miniblog/screens/blog_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> blogs = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // API'yi çağır ve sonuçları al
  //   loadBlogs();
  // }

  // void loadBlogs() async {
  //   var response = await http
  //       .get(Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles"));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       // Bilgiyi ekran da gosterecegimiz icin setState kullanmamiz gereklidir.
  //       blogs = List<Map<String, dynamic>>.from(json.decode(response.body));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ana Sayfa"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const AddBlog()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const BlogList(),

      //ListView.builder(
      //   itemCount: blogs.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       margin: const EdgeInsets.all(12),
      //       decoration: BoxDecoration(
      //           border: Border.all(style: BorderStyle.solid),
      //           borderRadius: BorderRadius.circular(20)),
      //       child: Column(
      //         children: [
      //           Text(
      //             blogs[index]["title"],
      //           ),
      //           Text(
      //             blogs[index]['content'],
      //             textAlign: TextAlign.center,
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           Image.network(
      //             blogs[index]['thumbnail'],
      //             height: 100,
      //           ),
      //           Text(blogs[index]['author']),
      //           const SizedBox(
      //             height: 30,
      //           )
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:miniblog/screens/add_blog.dart';
// import 'package:http/http.dart' as http;

// // import 'package:miniblog/themes/dark_theme.dart';
// // import 'package:miniblog/themes/light_theme.dart';
// // import 'package:shared_preferences/shared_preferences.dart';




// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {


//   // _readThemeData() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   bool? isDark = preferences.getBool("DARKTHEME");
//   //   if (isDark != null && isDark) {
//   //     setState(() {
//   //       themeMode = ThemeMode.dark;
//   //     });
//   //   }
//   // }

//   // _changeTheme(bool value) {
//   //   setState(() {
//   //     themeMode = value ? ThemeMode.dark : ThemeMode.light; // Sync
//   //     _writeThemeData(value);
//   //   });
//   // }

//   // Veri yazmak, veri okumak
//   // Http cevabı beklemek
//   // _writeThemeData(bool value) async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   preferences.setBool("DARKTHEME", value);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Ana Sayfa"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => AddBlog()));
//               },
//               icon: const Icon(Icons.add))
//         ],
//       ),
//       body: const  Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text("Merhaba"),
//         ]),
//       ),
//     );
//   }
// }
