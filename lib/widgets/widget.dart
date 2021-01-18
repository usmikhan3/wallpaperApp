import 'package:flutter/material.dart';
import 'package:wallfy/model/wallpaperModel.dart';
import 'package:wallfy/screens/imageView.dart';

Widget brandName() {
  // return Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   children: [
  //     Text(
  //       "Wallpaper",
  //       style: TextStyle(color: Colors.black),
  //     ),
  //     Text("Hub", style: TextStyle(color: Colors.blue))
  //   ],
  // );

  return RichText(
    text: TextSpan(
      text: 'Wallpaper',
      style: TextStyle(color: Colors.black,fontSize: 20),
      children: <TextSpan>[
        TextSpan(text: 'Hub', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 20)),
        //TextSpan(text: ' world!'),
      ],
    ),
  );
}

Widget wallpaperList({List<WallpaperModel> wallpapers, BuildContext context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding: EdgeInsets.only(bottom: 10),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>ImageView(imgUrl:wallpaper.src.portrait ,)));},
              child: Hero(
              tag: wallpaper.src.portrait,
                child: Container(
          child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.fitHeight,
                ),
          ),
        ),
              ),
            ));
      }).toList(),
    ),
  );
}
