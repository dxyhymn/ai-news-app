class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String source;
  final String author;
  final String imageUrl;
  final String url;
  final String category;
  final DateTime publishedAt;
  final bool isBookmarked;

  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.source,
    required this.author,
    required this.imageUrl,
    required this.url,
    required this.category,
    required this.publishedAt,
    this.isBookmarked = false,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      summary: json['summary'] ?? json['description'] ?? '',
      content: json['content'] ?? '',
      source: json['source'] is Map
          ? json['source']['name'] ?? ''
          : json['source'] ?? '',
      author: json['author'] ?? '未知',
      imageUrl: json['urlToImage'] ?? json['imageUrl'] ?? '',
      url: json['url'] ?? '',
      category: json['category'] ?? '综合',
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  NewsArticle copyWith({bool? isBookmarked}) {
    return NewsArticle(
      id: id,
      title: title,
      summary: summary,
      content: content,
      source: source,
      author: author,
      imageUrl: imageUrl,
      url: url,
      category: category,
      publishedAt: publishedAt,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}

class NewsCategory {
  final String id;
  final String name;
  final String icon;

  const NewsCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  static const List<NewsCategory> categories = [
    NewsCategory(id: 'all', name: '全部', icon: '🔥'),
    NewsCategory(id: 'llm', name: '大模型', icon: '🧠'),
    NewsCategory(id: 'agent', name: 'AI Agent', icon: '🤖'),
    NewsCategory(id: 'vision', name: '计算机视觉', icon: '👁️'),
    NewsCategory(id: 'robotics', name: '机器人', icon: '🦾'),
    NewsCategory(id: 'auto', name: '自动驾驶', icon: '🚗'),
    NewsCategory(id: 'chip', name: 'AI 芯片', icon: '💾'),
    NewsCategory(id: 'research', name: '学术论文', icon: '📄'),
    NewsCategory(id: 'product', name: '产品发布', icon: '🚀'),
    NewsCategory(id: 'investment', name: '投融资', icon: '💰'),
  ];
}
