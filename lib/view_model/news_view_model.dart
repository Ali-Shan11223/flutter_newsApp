import 'package:flutter_news_app/models/news_channel_headlines_model.dart';
import 'package:flutter_news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelHeadlinesModel> newsChannelHeadlinesApi(String channelName) async {
    final response = await _repo.newsChannelHeadlinesApi(channelName);
    return response;
  }
}
