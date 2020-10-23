 import 'dart:convert';


 List<Album> albumFromJson(String str) =>
     List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

 String albumToJson(List<Album> data) =>
     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album{
   int userId;
   int id;
   String title;

   Album({this.userId, this.id, this.title});



   factory Album.fromJson(Map<String,dynamic> json){
     return Album(userId: json['userId'],id: json['id'],title : json['title']);
   }

   Map<String,dynamic> toJson() =>{'userId':this.userId,'id':this.id,'title':this.title};

   static List<Album> filterList(List<Album> albums,String filterString){
     List<Album> searchedAlbumList= new List<Album>();
      albums.forEach((album) {
      if(album.title.toString().toLowerCase().contains(filterString.toString().toLowerCase())){
        searchedAlbumList.add(album);
      }
     });

      return searchedAlbumList;
   }
}