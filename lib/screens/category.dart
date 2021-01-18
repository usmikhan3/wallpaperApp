import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallfy/data/data.dart';
import 'package:wallfy/model/wallpaperModel.dart';
import 'package:wallfy/widgets/widget.dart';

import '../apiKey.dart';


class CategoryScreen extends StatefulWidget {

  final String categoryName;

  const CategoryScreen({this.categoryName}) ;
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  WallpaperModel wallpaperModel = new WallpaperModel();
  List<WallpaperModel> wallpapers = new List();

  getCategoryWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=16&page=1",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});

    //print(response.body.toString());
  }

  @override
  void initState() {
    getCategoryWallpapers(widget.categoryName);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 16,),
              wallpaperList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
