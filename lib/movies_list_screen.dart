
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final List<Movie> movieList = [];

  @override
  void initState() {
    super.initState();
    _getMovieList();
  }

  void _getMovieList(){
    _firebaseFirestore.collection("movies").get().then((value) {
      movieList.clear();
      for(QueryDocumentSnapshot doc in value.docs){
        movieList.add(Movie.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text('Moves'),
              subtitle: Text('languages'),
              leading: Text('1.4'),
              trailing: Text('2020'),
            );
          },
          separatorBuilder: (_,__) => const Divider(),
          ),
    );
  }
}


class Movie{
  final String id, name, languages, year;

  Movie(
      {required this.id,
      required this.name,
      required this.languages,
      required this.year});

  factory Movie.fromJson(String id, Map<String, dynamic> json){
    return Movie(
        id: id,
        name: json['name'],
        languages: json['languages'],
        year: json['year']);
  }
}