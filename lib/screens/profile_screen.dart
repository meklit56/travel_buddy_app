// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _datesController = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      final data = snapshot.data();
      if (data != null) {
        _nameController.text = data['name'] ?? '';
        _interestController.text = data['interest'] ?? '';
        _datesController.text = data['tripDates'] ?? '';
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .set({
        'name': _nameController.text.trim(),
        'interest': _interestController.text.trim(),
        'tripDates': _datesController.text.trim(),
        'email': _user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _interestController,
              decoration: const InputDecoration(labelText: 'Travel Interest'),
            ),
            TextField(
              controller: _datesController,
              decoration: const InputDecoration(labelText: 'Trip Dates'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
