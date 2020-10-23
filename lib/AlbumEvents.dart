
import 'package:equatable/equatable.dart';

abstract class AlbumEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchAlbums extends AlbumEvents{
  @override
  List<Object> get props => [];
}

class SearchedAlbum extends AlbumEvents{
 final String filterString;

 SearchedAlbum(this.filterString);
  @override
  List<Object> get props => [this.filterString];
}