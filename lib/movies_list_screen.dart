import 'package:flutter/material.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

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
