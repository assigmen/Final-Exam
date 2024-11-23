import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  // Placeholder list of news items
  final List<String> newsItems = [
    'Breaking News: New update available!',
    'New Feature: Try out the latest functionality!',
    'Important Notice: Scheduled maintenance tomorrow.',
    'Community Event: Join our upcoming meetup!'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: newsItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(newsItems[index]),
                subtitle: Text('Published on ${DateTime.now().toLocal()}'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Handle tap on news item, for now just show a message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tapped on: ${newsItems[index]}')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
