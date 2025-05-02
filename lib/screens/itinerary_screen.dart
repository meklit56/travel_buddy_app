// itinerary_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _destinations = [];
  late String _userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      _loadItinerary();
    }
  }

  Future<void> _loadItinerary() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('itineraries')
        .doc(_userId)
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      setState(() {
        _destinations = List<String>.from(data?['destinations'] ?? []);
      });
    }
  }

  Future<void> _saveItinerary() async {
    await FirebaseFirestore.instance.collection('itineraries').doc(_userId).set({
      'destinations': _destinations,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  void _addDestination() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _destinations.add(text);
        _controller.clear();
      });
      _saveItinerary();
    }
  }

  void _removeDestination(int index) {
    setState(() => _destinations.removeAt(index));
    _saveItinerary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Itinerary Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Add a destination',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addDestination,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _destinations.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_destinations[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeDestination(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
