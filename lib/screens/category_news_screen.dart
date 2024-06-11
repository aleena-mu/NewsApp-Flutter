import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../util/secrets.dart';

class CategoryNewsPage extends StatefulWidget {
  final String categoryName;
  const CategoryNewsPage({super.key, required this.categoryName});

  @override
  State<CategoryNewsPage> createState() => _CategoryNewsPageState();
}


class _CategoryNewsPageState extends State<CategoryNewsPage> {

  Future getNews() async {
    final category=widget.categoryName;
    print(category);
    try {

      final res = await http.get(
        Uri.parse(

            'https://newsapi.org/v2/top-headlines?category=$category&language=en&apiKey=$newsAPIKey'),
      );
      final data = jsonDecode(res.body);
      if (data['status'] != 'ok') {
        throw 'An unexpected Error Occurred';
      }

      return data;
      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.categoryName.substring(0, 1).toUpperCase() +
            widget.categoryName.substring(1),),
      ),
      body: FutureBuilder(
          future: getNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data;
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final articleData = data['articles'][index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: GestureDetector(
                    onTap:  () {
                      setState(() {
                        _launchUrl(articleData['url']);
                      });
                    },
                    child: ListTile(
                      leading: SizedBox(
                        width: 100,
                        height: 200,
                        child: Image.network(
                          articleData['urlToImage'].toString(),
                          alignment: Alignment.center,
                        ),
                      ),
                      title: Text(articleData['title']),
                      subtitle: Text(
                        articleData['source']['name'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
