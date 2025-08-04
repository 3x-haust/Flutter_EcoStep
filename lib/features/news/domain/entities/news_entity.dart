class NewsEntity {
  final String id;
  final String title;
  final String content;
  final String coverImageUrl;
  final String authorName;
  final String publishedDate;
  final String newsSource;
  final String newsSourceLogo;
  final List<NewsImageEntity> contentImages;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.coverImageUrl,
    required this.authorName,
    required this.publishedDate,
    required this.newsSource,
    required this.newsSourceLogo,
    required this.contentImages,
  });
}

class NewsImageEntity {
  final String imageUrl;
  final String caption;
  final String source;

  const NewsImageEntity({
    required this.imageUrl,
    required this.caption,
    required this.source,
  });
}
