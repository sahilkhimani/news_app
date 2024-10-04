import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_app/home_model.dart';
import 'package:news_app/news_detail_page.dart';

class HomeClass extends StatefulWidget {
  const HomeClass({super.key});

  @override
  State<HomeClass> createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass> {
  var key = "YourApiKey";
  String q = "top";
  String? countryName = "pk";
  String lang = "en";
  String categ = "Top";

  List countryList = [
    {"id": "af", "title": "Afghanistan"},
    {"id": "al", "title": "Albania"},
    {"id": "au", "title": "Australia"},
    {"id": "ca", "title": "Canada"},
    {"id": "cn", "title": "China"},
    {"id": "de", "title": "Germany"},
    {"id": "in", "title": "India"},
    {"id": "ir", "title": "Iran"},
    {"id": "jp", "title": "Japan"},
    {"id": "sg", "title": "Singapore"},
    {"id": "us", "title": "USA"}
  ];

  List<String> categoryList = [
    'Top',
    'Business',
    'Crime',
    'Domestic',
    'Education',
    'Entertainment',
    'Politics',
    'Science',
    'World',
    'Technology'
  ];
  TextEditingController searchBoxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Align(
            alignment: Alignment.centerRight, child: Icon(Icons.notifications)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorHeight: 15,
                      controller: searchBoxController,
                      style: const TextStyle(height: 0.6),
                      decoration: const InputDecoration(
                          hintText: "Search News",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: countryName,
                          menuMaxHeight: 200,
                          items: [
                            const DropdownMenuItem(
                              value: "pk",
                              child: Text("Pakistan"),
                            ),
                            ...countryList
                                .map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem(
                                value: item['id'],
                                child: Text(item['title']),
                              );
                            }),
                          ],
                          onChanged: (value) {
                            setState(() {
                              countryName = value;
                            });
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Discover a world of news that matters to you",
                style: TextStyle(fontSize: 1),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var item in categoryList)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            categ = item;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: item == categ
                                ? Colors.black
                                : Colors.transparent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 18,
                                color: item == categ
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: getNewsResult(
                      apiKey: key,
                      country: countryName,
                      language: lang,
                      category: categ),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<HomeModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            NewsDetail(
                                              data: snapshot.data?[index] ??
                                                  HomeModel("12345"),
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      snapshot.data?[index].imageUrl ??
                                          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"),
                                  const SizedBox(height: 10),
                                  Text(
                                    snapshot.data?[index].title ?? "  Title",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Image.network(
                                          width: 40,
                                          height: 40,
                                          snapshot.data?[index].sourceIcon ??
                                              "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"),
                                      const SizedBox(width: 10),
                                      Text(
                                        snapshot.data?[index].sourceName ??
                                            "No Source",
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      getDateAndDay(
                                          snapshot.data?[index].pubDate ??
                                              "2024-10-03 01:57:35"),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }

  Future<List<HomeModel>> getNewsResult(
      {required apiKey, country, language, category}) async {
    List<HomeModel> newsList = [];
    var apiUrl =
        "https://newsdata.io/api/1/news?apikey=$apiKey&country=$country&language=$language&category=$category";
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var item in responseBody['results']) {
      newsList.add(HomeModel.fromJson(item, responseBody['nextPage']));
    }
    return newsList;
  }
}

String getDateAndDay(String inputDate) {
  DateTime dt = DateTime.parse(inputDate);
  String day = DateFormat('EEEE').format(dt);
  String date = DateFormat(' MMMM d').format(dt);
  return "$day |$date";
}
