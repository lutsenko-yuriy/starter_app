import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Welcome to Flutter",
        home: Scaffold(
          appBar: AppBar(
              title: const Text("Welcome to Flutter")
          ),
          body: const Center(
            child: RandomWords(),
          ),
        )
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        final suggestion = _suggestions[index];

        final alreadySaved = _saved.contains(suggestion);

        return ListTile(
          title: Text(
            suggestion.asCamelCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? "Removed from saved" : "Save",
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(suggestion);
              } else {
                _saved.add(suggestion);
              }
            });
          },
        );
      },
    );
  }
}
