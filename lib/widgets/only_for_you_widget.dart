import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/secrets.dart';

class OnlyForYouNewsWidget extends StatefulWidget {
  final int indexValue;
  const OnlyForYouNewsWidget({
    super.key,
    required this.indexValue});

  @override
  State<OnlyForYouNewsWidget> createState() => _OnlyForYouNewsWidgetState();
}

class _OnlyForYouNewsWidgetState extends State<OnlyForYouNewsWidget> {

  Future getNews() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=in&apiKey=$newsAPIKey'),
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
  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNews(),
      builder:(context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        final data = snapshot.data;
        final articleData=data['articles'][widget.indexValue];
        final imageValue=articleData['urlToImage'];


        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              setState(() {
                _launchUrl(articleData['url']);
              });
            },
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 130,
                  child: Image.network(imageValue ?? 'assets/images/cnnlogo.png',fit: BoxFit.fill,),
                ),
                 Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(articleData['description']??'Read More...',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(

                        width: 200,
                        child: Row(
                          children: [

                            SizedBox(
                              width:120,
                              child: Text(articleData['author'] ?? 'Author',style: const TextStyle(color: Colors.grey,
                                  fontSize: 15),
                              ),
                            ),
                            // Spacer(),
                            // Text(date, style: TextStyle(color: Colors.grey,
                            //     fontSize: 15),),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );

      },
    );
  }
}
