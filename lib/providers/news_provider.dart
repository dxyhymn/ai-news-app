import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<NewsArticle> _articles = [];
  List<NewsArticle> _searchResults = [];
  Set<String> _bookmarkedIds = {};
  String _selectedCategory = 'all';
  bool _isLoading = false;
  bool _isSearching = false;
  String _searchQuery = '';
  int _currentPage = 1;
  bool _hasMore = true;

  List<NewsArticle> get articles => _articles;
  List<NewsArticle> get searchResults => _searchResults;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;
  bool get hasMore => _hasMore;

  List<NewsArticle> get bookmarkedArticles => _articles
      .where((a) => _bookmarkedIds.contains(a.id))
      .toList();

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  Future<void> loadNews({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final news = await _newsService.fetchNews(
        category: _selectedCategory,
        page: _currentPage,
      );

      if (refresh) {
        _articles = news;
      } else {
        _articles.addAll(news);
      }

      _hasMore = news.length >= 20;
      _currentPage++;
    } catch (e) {
      print('Error loading news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String categoryId) {
    if (_selectedCategory == categoryId) return;
    _selectedCategory = categoryId;
    _articles = [];
    notifyListeners();
    loadNews(refresh: true);
  }

  Future<void> searchNews(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await _newsService.searchNews(query);
    } catch (e) {
      print('Error searching: $e');
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void toggleBookmark(String articleId) {
    if (_bookmarkedIds.contains(articleId)) {
      _bookmarkedIds.remove(articleId);
    } else {
      _bookmarkedIds.add(articleId);
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
