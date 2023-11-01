import 'package:flutter_news_app/models/category_news_model.dart';
import 'package:flutter_news_app/models/news_channel_headlines_model.dart';
import 'package:flutter_news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelHeadlinesModel> newsChannelHeadlinesApi(
      String channelName) async {
    final response = await _repo.newsChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoryNewsModel> fetchCategoryNewsApi(String category) async {
    final response = await _repo.fetchCategoryNewsApi(category);
    return response;
  }
}
