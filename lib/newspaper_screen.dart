import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<void> _loadNews() async {
    final response = await http.get(Uri.parse('https://n59der.deta.dev/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _newsList = data['newsItems'];
      });
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NEWS SECTION'),
        ),
        body: _newsList.isEmpty
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
                        print('REDIRECTING');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailsScreen(news: _newsList[index]),
                            ));
                      },
                      child: Card(
                        elevation: 3,
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Image.network(
                              newsData['imageURL'],
                              width: 60,
                            ),
                            //  CachedNetworkImage(
                            //   imageUrl: newsData['imageURL'],
                            //   placeholder: (context, url) => const Icon(Icons.error),
                            //   errorWidget: (context, url, error) => Icon(Icons.error),
                            // ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                newsData['heading'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 8),
                              child: Text(
                                newsData['source'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
