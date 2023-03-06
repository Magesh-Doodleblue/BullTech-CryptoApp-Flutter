
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
