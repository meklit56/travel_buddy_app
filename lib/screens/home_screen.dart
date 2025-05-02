// home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Buddy Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user?.email ?? 'Traveler'}!',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/match'),
              icon: const Icon(Icons.people),
              label: const Text('Find Travel Buddies'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/itinerary'),
              icon: const Icon(Icons.edit_calendar),
              label: const Text('Plan Itinerary'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/map'),
              icon: const Icon(Icons.map),
              label: const Text('Explore Map'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/feed'),
              icon: const Icon(Icons.photo_album),
              label: const Text('View Trip Feed'),
            ),
          ],
        ),
      ),
    );
  }
}
