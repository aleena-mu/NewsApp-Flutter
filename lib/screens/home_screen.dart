import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:news_app/screens/all_breaking_news_screen.dart';
import 'package:news_app/screens/only_for_you_news_screen.dart';

import 'package:news_app/util/secrets.dart';
import 'package:news_app/widgets/explore_widget.dart';
import 'package:news_app/widgets/only_for_you_widget.dart';

import '../widgets/breaking_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categoryImages = const [
    'techNewsIcon.jpg',
    'politicalImage.jpg',
    'financeIcon.jpg',
    'sportsIcon.jpg'
  ];
  final List<String> categories = const [
    'technology',
    'politics',
    'business',
    'sports'
  ];

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset("assets/images/newsAppIcon.png"),
            ),
            const SizedBox(width: 10),
            TextButton(onPressed: (){
              setState(() {

              });
            }, child: Text(
                'News App',
                style: Theme.of(context).textTheme.titleLarge,
            ),)

          ],
        ),
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

          return Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Breaking News',
                        style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AllBreakingNews();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final articleData = data['articles'][index + 6];
                      final date = DateTime.parse(articleData['publishedAt']);
                      return BreakingNews(
                        image: articleData['urlToImage'],
                        author: articleData['source']['name'],
                        date: DateFormat.MMMMd().format(date),
                        description: articleData['description'],
                        url: articleData['url'],
                      );
                    },
                  ),
                ),
                Text('Explore', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryImages.length,
                    itemBuilder: (context, index) {
                      final imageName = categoryImages[index];
                      final categoryName = categories[index];
                      return ExploreWidget(
                        imageName: imageName,
                        categoryName: categoryName,
                      );
                    },
                  ),
                ),
              const SizedBox(height:15),
                Row(
                  children: [
                    Text('Only For You',
                        style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const OnlyForYouNewsScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const OnlyForYouNewsWidget(indexValue: 0),
              ],
            ),
          );
        },
      ),
    );
  }
}
