import 'package:flutter/material.dart';
import 'package:news_app/widgets/only_for_you_widget.dart';

class OnlyForYouNewsScreen extends StatelessWidget {
  const OnlyForYouNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Only For You'),
      ),
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context,index){
          return OnlyForYouNewsWidget(indexValue: index+6);

          }),
    );
  }
}
