
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
          itemCount: movieList.length,
          itemBuilder: (context, index) {
            return  ListTile(
              title: Text(movieList[index].name),
              subtitle: Text(movieList[index].languages),
              leading: Text(movieList[index].rating),
              trailing: Text(movieList[index].year),
            );
          },
          separatorBuilder: (_,__) => const Divider(),
          ),
    );
  }
}


class Movie{
  final String id, name, languages, year, rating;

  Movie(
      {required this.id,
      required this.name,
      required this.languages,
      required this.rating,
      required this.year});

  factory Movie.fromJson(String id, Map<String, dynamic> json){
    return Movie(
        id: id,
        name: json['name'],
        languages: json['languages'],
        rating: json['rating'] ?? 'Unknown',
        year: json['year']);
  }
}