import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TwitterFeed extends StatefulWidget {
  const TwitterFeed({super.key});

  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  late Future<List> _tweets;

  Future<List> fetchTweets() async {
    // Reemplaza con la URL de tu backend desplegado
    final url = Uri.parse('https://esports-news-fn3lzpdsz-jxvierzzs-projects.vercel.app/tweets');
     print('Fetch tweets from: $url');  // Agrega esto
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'] ?? [];
    } else {
      throw Exception('Failed to load tweets');
    }
  }

  @override
  void initState() {
    super.initState();
    _tweets = fetchTweets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _tweets,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final tweets = snapshot.data!;
          if (tweets.isEmpty) {
            return const Center(child: Text('No tweets found.'));
          }
          return ListView.builder(
            itemCount: tweets.length,
            itemBuilder: (context, index) {
              var tweet = tweets[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(tweet['text'] ?? ''),
                  subtitle: Text(tweet['created_at'] ?? ''),
                ),
              );
            },
          );
        }
      },
    );
  }
}
