// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _newsList = [];
  final http.Client _client = http.Client(); // Add this line

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  @override
  void dispose() {
    _client.close(); // Add this line to cancel the http request
    super.dispose();
  }

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

      // setState(() {
      //   _newsList = newsList;
      // });
      if (mounted) {
        setState(() {
          _newsList = newsList;
        });
      }
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  Future<void> _refreshNewsList() async {
    await _loadNews();
  }

  Future<bool> _onWillPop() async {
    bool closeApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the App?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 66, 66),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 66, 66),
              ),
            ),
          ),
        ],
      ),
    );
    if (closeApp == true) {
      SystemNavigator.pop();
    }

    return closeApp;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'NEWS SECTION',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 66, 66),
            ),
          ),
        ),
        body: newspaperWidget(),
      ),
    );
  }

  RefreshIndicator newspaperWidget() {
    return RefreshIndicator(
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
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('REDIRECTING');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailsScreen(news: newsData),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: "newsImage_${newsData['imageUrl']}",
                            child: Image.network(
                              newsData['imageUrl'],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
