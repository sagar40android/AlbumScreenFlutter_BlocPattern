import 'package:album_screen_bloc_pattern/Album.dart';
import 'package:equatable/equatable.dart';

abstract class AlbumsState extends Equatable{
  @override
  List<Object> get props => [];
}

class AlbumInitState extends AlbumsState{

}

class LoadingAlbumState extends AlbumsState{

}

class LoadedAlbumState extends AlbumsState{
final List<Album> albums;

LoadedAlbumState(this.albums);

List<Album> get getAlbums=> this.albums;
@override
List<Object> get props => [this.albums];
}

class ErrorState extends AlbumsState{

}