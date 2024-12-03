import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart'; // Import your login screen file

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'HOME',
            style: TextStyle(
              color: Colors.white, // Set text color to white
              fontWeight: FontWeight.bold, // Set text to bold
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 162, 197, 0.7),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ${user.email}',
              style: const TextStyle(fontSize: 20),
            ),
            UserDetails(user: user),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(title: 'LOGIN'),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while fetching data
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error message if any
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available'); // Show message if no data found
        }

        // Extract user details from snapshot
        final data = snapshot.data!.data() as Map<String, dynamic>;
        final name = data['name'] ?? 'N/A';
        final email = data['email'] ?? 'N/A';
        final phoneNumber = data['phoneNumber'] ?? 'N/A';

        return Column(
          children: [
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone Number: $phoneNumber'),
            // Add more fields as needed
          ],
        );
      },
    );
  }
}
