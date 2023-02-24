import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

/////////////////// OLD LAGGING NEWS API
  // Future<void> _loadNews() async {
  //   final response = await http.get(Uri.parse('https://n59der.deta.dev/'));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       _newsList = data['newsItems'];
  //     });
  //   } else {
  //     throw Exception('Failed to fetch news');
  //   }
  // }
  Future<void> _loadNews() async {
    final response = await http.get(Uri.parse('https://cointelegraph.com/rss'));
    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      List<Map<String, dynamic>> newsList = [];

      for (var item in items) {
        final title = item.findElements('title').single.text;
        final link = item.findElements('link').single.text;
        final pubDate = item.findElements('pubDate').single.text;
        final descriptionWithTags =
            item.findElements('description').single.text;
        final imageUrl =
            item.findElements('media:content').single.getAttribute('url');
        final regex = RegExp('<p>(.*?)</p>');
        final description =
            regex.firstMatch(descriptionWithTags)?.group(1) ?? '';

        final newsItem = {
          'title': title,
          'link': link,
          'pubDate': pubDate,
          'description': description,
          'imageUrl': imageUrl,
        };

        newsList.add(newsItem);
      }

      setState(() {
        _newsList = newsList;
      });
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  Future<void> _refreshNewsList() async {
    await _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('NEWS SECTION'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNewsList,
        child: _newsList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  final newsData = _newsList[index] as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print('REDIRECTING');
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailsScreen(news: newsData),
                            ));
                      },
                      child: Card(
                        elevation: 3,
                        child: Container(
                          color: Colors.black87,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                newsData['imageUrl'],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  newsData['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  newsData['pubDate'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  newsData['description'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class News {
  String heading;
  String description;
  String imageURL;
  String source;

  News({
    required this.heading,
    required this.description,
    required this.imageURL,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      heading: json['heading'],
      description: json['description'],
      imageURL: json['imageURL'],
      source: json['source'],
    );
  }
}
