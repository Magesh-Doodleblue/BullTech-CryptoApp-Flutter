import 'package:flutter/material.dart';

import 'newspaper_screen.dart';

class NewsDetailsScreen extends StatelessWidget {
  final dynamic news;

  const NewsDetailsScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (news['imageURL'] != null)
              Image.network(
                news['imageURL'],
                // width: 300,
                height: 200,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news['pubDate'],
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18.0),
                  // Text(
                  //   'By ${news['source']}',
                  //   style: const TextStyle(fontSize: 18.0),
                  // ),
                  const SizedBox(height: 26.0),
                  Text(
                    news['description'],
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
