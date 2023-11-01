import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String image, title, description, date, source, author;
  const NewsDetailsScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.date,
      required this.source,
      required this.author});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    final DateTime dateTime = DateTime.parse(widget.date);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        SizedBox(
          height: height * 0.45,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: CachedNetworkImage(
              imageUrl: widget.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: height * 0.6,
          margin: EdgeInsets.only(top: height * 0.4),
          padding: const EdgeInsets.all(15),
          width: width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.source,
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      format.format(dateTime),
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  widget.author,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
