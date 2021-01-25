
import 'dart:ui';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';


class ImageView extends StatefulWidget {



  final String imgUrl;

  const ImageView({@required this.imgUrl}) ;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl,fit: BoxFit.cover,)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async{
                      await ImageDownloader.downloadImage(widget.imgUrl);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width /2,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white60,width: 1),
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36FFFFFF),
                          Color(0x0FFFFFFF),
                        ]
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Set Wallpaper",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800)),
                          Text("Image will be saved in gallery",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.white),)),
                SizedBox(height: 30,)
              ],
            ),
          )
        ],
      ),
    );
  }

  // _save() async {
  //   if(Platform.isAndroid){
  //     await _askPermission();
  //   }
  //     var response = await Dio().get(widget.imgUrl,
  //         options: Options(responseType: ResponseType.bytes));
  //     final result =
  //     await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  //     print(result);
  //     Navigator.pop(context);
  //
  //
  //
  // }



  // _askPermission() async {
  //   if (Platform.isIOS) {
  //     var status = await Permission.photos.status;
  //   }
  // }

}
