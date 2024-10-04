import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/home_model.dart';

class NewsDetail extends StatelessWidget {
  final HomeModel? data;
  const NewsDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  data?.imageUrl ??
                      "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
                ),
                const SizedBox(height: 20),
                Text(
                  data?.title ?? "  Title",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  data?.description ?? "No Description",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("News By:"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Image.network(
                        width: 60,
                        height: 60,
                        data?.sourceIcon ??
                            "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"),
                    const SizedBox(width: 10),
                    Text(
                      data?.sourceName ?? "No Source",
                      style: const TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  getDateAndDay(data?.pubDate ?? "2024-10-03 01:57:35"),
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
        ));
  }
}

String getDateAndDay(String inputDate) {
  DateTime dt = DateTime.parse(inputDate);
  String day = DateFormat('EEEE').format(dt);
  String date = DateFormat(' MMMM d').format(dt);
  return "$day |$date";
}
