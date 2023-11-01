import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/news_channel_headlines_model.dart';

class NewsRepository {
  //Fun to fetch data from api
  Future<NewsChannelHeadlinesModel> newsChannelHeadlinesApi(String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=0cb3ce6b8d694d49a42bdb8b008ca152";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(data);
    }
    throw Exception('Error');
  }
}
