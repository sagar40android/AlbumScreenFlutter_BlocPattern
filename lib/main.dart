import 'dart:async';

import 'package:album_screen_bloc_pattern/AlbumEvents.dart';
import 'package:album_screen_bloc_pattern/AlbumsBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Album.dart';
import 'AlbumServices.dart';
import 'AlbumsState.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: BlocProvider(
        create: (context)=> AlbumsBloc(AlbumServices()),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback actions;
  Timer _timer;


  Debouncer({this.milliseconds});

  void run(VoidCallback actions){
    if(null != _timer){
      _timer.cancel();
    }

_timer = Timer(Duration(milliseconds: 1000), actions);
  }
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
      BlocProvider.of<AlbumsBloc>(context).add(FetchAlbums());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Block"),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Searched Text",
                  contentPadding: EdgeInsets.all(15)
              ),
              onChanged: (value){
                BlocProvider.of<AlbumsBloc>(context).add(SearchedAlbum(value));
              },

            ),
            SizedBox(height: 10,),
            Expanded(
              child: BlocBuilder<AlbumsBloc,AlbumsState>(builder: (context,state){
                // if(state is AlbumInitState){
                //   return Center(child: CircularProgressIndicator(),);
                // }else
                if(state is LoadingAlbumState){
                  return Center(child: CircularProgressIndicator(),);
                }else  if(state is LoadedAlbumState){
                  return albumListView(state.albums);
                }else if(state is ErrorState){
                  return Center(child: Text("Not Data Found "),);
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },),
            ),
          ],
        ),
      )





    );
  }

  Widget albumListView(List<Album> albums){
    return ListView.builder(itemCount: albums == null ? 0 : albums.length,
        itemBuilder: (context,index){
          Album album = albums[index];
          return ListTile(
            title:  Text("Id : "+album.id.toString()),
            subtitle: Text("title : "+album.title),
          );
        });
  }
}




