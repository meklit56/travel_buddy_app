// match_screen.dart
import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data
    final List<Map<String, String>> matches = [
      {
        'name': 'Liya',
        'interest': 'Hiking in Switzerland',
        'dates': 'June 10 - June 20',
      },
      {
        'name': 'Jonas',
        'interest': 'Beach in Thailand',
        'dates': 'July 1 - July 10',
      },
      {
        'name': 'Sara',
        'interest': 'Exploring Ethiopia',
        'dates': 'May 15 - May 25',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Find Travel Buddies')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final buddy = matches[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(buddy['name']!),
              subtitle: Text('${buddy['interest']}\n${buddy['dates']}'),
              isThreeLine: true,
              trailing: ElevatedButton(
                onPressed: () {
                  // In a real app, this would open the chat screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Starting chat with ${buddy['name']}...')),
                  );
                },
                child: const Text('Chat'),
              ),
            ),
          );
        },
      ),
    );
  }
}
