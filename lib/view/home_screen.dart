import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/news_channel_headlines_model.dart';
import 'package:flutter_news_app/view/category_screen.dart';
import 'package:flutter_news_app/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/category_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, cnn, alJazeera, aryNews, reuters, businessInsider }

class _HomeScreenState extends State<HomeScreen> {
  final NewsViewModel newsViewModel = NewsViewModel();
  String channelName = 'bbc-news';

  FilterList? selectedChannel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    final format = DateFormat('MMMM dd, yyyy');

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryScreen()));
              },
              icon: Image.asset(
                'assets/images/category_icon.png',
                height: 20,
                width: 20,
              )),
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<FilterList>(
                icon: const Icon(Icons.more_vert),
                initialValue: selectedChannel,
                onSelected: (FilterList item) {
                  if (FilterList.bbcNews.name == item.name) {
                    channelName = 'bbc-news';
                  }
                  if (FilterList.cnn.name == item.name) {
                    channelName = 'cnn';
                  }
                  if (FilterList.alJazeera.name == item.name) {
                    channelName = 'al-jazeera-english';
                  }
                  if (FilterList.aryNews.name == item.name) {
                    channelName = 'ary-news';
                  }
                  if (FilterList.reuters.name == item.name) {
                    channelName = 'reuters';
                  }
                  if (FilterList.businessInsider.name == item.name) {
                    channelName = 'business-insider';
                  }
                  setState(() {
                    selectedChannel = item;
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      const PopupMenuItem(
                          value: FilterList.bbcNews, child: Text('BBC News')),
                      const PopupMenuItem(
                          value: FilterList.cnn, child: Text('CNN')),
                      const PopupMenuItem(
                          value: FilterList.alJazeera,
                          child: Text('Al-Jazeera English')),
                      const PopupMenuItem(
                          value: FilterList.aryNews, child: Text('Ary News')),
                      const PopupMenuItem(
                          value: FilterList.reuters, child: Text('Reuters')),
                      const PopupMenuItem(
                          value: FilterList.businessInsider,
                          child: Text('Business Insider')),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * 0.5,
              child: FutureBuilder<NewsChannelHeadlinesModel>(
                  future: newsViewModel.newsChannelHeadlinesApi(channelName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.7,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return const SpinKitFadingCircle(
                                            color: Colors.blue,
                                            size: 50,
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        height: height * 0.22,
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.blue),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchCategoryNewsApi('General'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * 0.20,
                                      width: width * 0.3,
                                      placeholder: (context, url) {
                                        return const SpinKitFadingCircle(
                                          color: Colors.blue,
                                          size: 50,
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    height: height * .20,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                            maxLines: 3,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
