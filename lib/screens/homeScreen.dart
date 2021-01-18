import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallfy/data/data.dart';
import 'package:wallfy/model/categoriesModel.dart';
import 'package:wallfy/model/wallpaperModel.dart';
import 'package:wallfy/screens/category.dart';
import 'package:wallfy/screens/imageView.dart';
import 'package:wallfy/screens/search.dart';
import 'package:wallfy/widgets/widget.dart';
import 'package:http/http.dart' as http;

import '../apiKey.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  WallpaperModel wallpaperModel = new WallpaperModel();
  TextEditingController searchController = TextEditingController();

  getTrendingWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15",
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
    getTrendingWallpapers();
    categories = getCategories();
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
              //Todo: TextField
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F8Fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search Wallpaper",
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(8)),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SearchScreen(
                                    searchQuery: searchController.text,
                                  ),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        },
                        child: Icon(Icons.search))
                  ],
                ),
              ),

              //Todo: Categories

              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        title: categories[index].categoriesName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              ),

              //Todo: Wallpapers
              SizedBox(
                height: 16,
              ),
              wallpaperList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, title;

  const CategoryTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(child: CategoryScreen(categoryName: title.toLowerCase(),), type: PageTransitionType.bottomToTop));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){

              },
              child: Hero(
                tag: imgUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imgUrl,
                    height: 50,
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black45,
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
