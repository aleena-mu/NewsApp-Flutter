import 'package:flutter/material.dart';

import '../screens/category_news_screen.dart';


class ExploreWidget extends StatefulWidget {
  final String imageName;
  final String categoryName;
  const ExploreWidget({
    Key? key,

    required this.imageName,
    required this.categoryName
  }): super(key: key);



  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CategoryNewsPage(categoryName: widget.categoryName);
              },
            ),
          );
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(

                image: AssetImage('assets/images/${widget.imageName}'),
              )
          ),

        ),

      ),
    );
  }
}