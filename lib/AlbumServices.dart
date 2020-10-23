import 'dart:convert';

import 'package:album_screen_bloc_pattern/Album.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' ;
class AlbumServices{

  static const String BASE_URL ="jsonplaceholder.typicode.com";
  static const GET_ALBUM= "/albums";
  
  Future<List<Album>>  getAlbum () async{
    try{
      Uri uri= Uri.https(BASE_URL, GET_ALBUM);
      http.Response response = await http.get(uri);
      if(response.statusCode == 200) {

          return albumFromJson(response.body);
      }else {
        return List<Album>();
      }
    }catch(e){
      throw e;
    }
  }
}