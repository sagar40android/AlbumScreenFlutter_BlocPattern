
import 'package:album_screen_bloc_pattern/AlbumEvents.dart';
import 'package:album_screen_bloc_pattern/AlbumsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Album.dart';
import 'AlbumServices.dart';

class AlbumsBloc extends Bloc<AlbumEvents,AlbumsState> {
  AlbumServices albumServices;
  List<Album> albums ;
  AlbumsBloc(this.albumServices) : super(AlbumInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumEvents event) async*{

    if(event is FetchAlbums){
      albums = new List<Album>();
      yield LoadingAlbumState();
      albums = await albumServices.getAlbum();
      yield LoadedAlbumState(albums);
    }else if(event is SearchedAlbum){

      List<Album> searchedAlbumList= new List<Album>();
      albums.forEach((album) {
        if(album.title.toString().toLowerCase().contains(event.filterString.toString().toLowerCase())){
          searchedAlbumList.add(album);
        }
      });

      if( searchedAlbumList.length == 0){
        yield LoadedAlbumState(albums);
      }else{
        yield LoadedAlbumState(searchedAlbumList);
      }


    }else{
      yield ErrorState();
    }
  }

}