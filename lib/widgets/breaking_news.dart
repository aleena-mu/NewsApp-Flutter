import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BreakingNews extends StatefulWidget {
  final String image;
  final String author;
  final String date;
  final String description;
  final String url;

  const BreakingNews({
    super.key,
    required this.image,
    required this.author,
    required this.date,
    required this.description,
    required this.url,
  });

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          setState(() {
            _launchUrl(widget.url);
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.image), // Use NetworkImage for API images
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 280,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  const SizedBox(width: 10),
                  Text(
                    widget.author,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                 const Spacer(),
                  Text(
                    widget.date,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
           const SizedBox(height: 10,),
            SizedBox(
              width: 280,
              child: Text(widget.description,style:const  TextStyle(color:Colors.black),
              overflow: TextOverflow.ellipsis,
                maxLines: 2,



              ),
            ),
          ],
        ),
      ),
    );
  }
}



