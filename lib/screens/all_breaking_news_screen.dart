import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../util/secrets.dart';

class AllBreakingNews extends StatefulWidget {
  const AllBreakingNews({super.key});

  @override
  State<AllBreakingNews> createState() => _AllBreakingNewsState();
}

class _AllBreakingNewsState extends State<AllBreakingNews> {
  Future getNews() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/top-headlines?language=en&apiKey=$newsAPIKey'),
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
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking News'),
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
                    onTap: () {
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
                          fit: BoxFit.fill,
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
