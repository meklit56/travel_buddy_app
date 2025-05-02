// match_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Find Travel Buddies')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No matches found.'));
          }

          final matches = snapshot.data!.docs.where((doc) => doc.id != currentUser?.uid).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final buddy = matches[index];
              final name = buddy['name'] ?? 'Unknown';
              final interest = buddy['interest'] ?? 'No interest listed';
              final dates = buddy['tripDates'] ?? 'Dates not available';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(name),
                  subtitle: Text('$interest\n$dates'),
                  isThreeLine: true,
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Start chat with $name (not implemented)')),
                      );
                    },
                    child: const Text('Chat'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
