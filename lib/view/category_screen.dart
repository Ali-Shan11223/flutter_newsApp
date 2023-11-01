import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/category_news_model.dart';
import 'package:flutter_news_app/view/news_details_screen.dart';
import 'package:flutter_news_app/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final NewsViewModel newsViewModel = NewsViewModel();

  List<String> categoryList = [
    'General',
    'Business',
    'Science',
    'Entertainment',
    'Health',
    'Sports',
    'Technology'
  ];

  String selectedCategory = 'General';

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategory = categoryList[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedCategory == categoryList[index]
                                  ? Colors.blue
                                  : Colors.grey.shade400),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                                child: Text(
                              categoryList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchCategoryNewsApi(selectedCategory),
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
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.articles![index];
                            final DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailsScreen(
                                                  image: data.urlToImage
                                                      .toString(),
                                                  title: data.title.toString(),
                                                  description: data.description
                                                      .toString(),
                                                  date: data.publishedAt
                                                      .toString(),
                                                  source: data.source!.name
                                                      .toString(),
                                                  author:
                                                      data.author.toString())));
                                },
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
                                        padding:
                                            const EdgeInsets.only(left: 15),
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
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
