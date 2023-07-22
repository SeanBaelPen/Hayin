import 'package:app/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PointsHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Points History'),
        backgroundColor: Colors.deepOrange,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: PointsHistoryList(),
    );
  }
}

class PointsHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService().getID()) // Assuming this gets the current user ID
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.exists == true) {
          final data = snapshot.data!;
          final pointsHistory = data['pointsHistory'] ?? [];

          return ListView.builder(
            itemCount: pointsHistory.length,
            itemBuilder: (context, index) {
              final entry = pointsHistory[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    entry['message'].startsWith('Earned') ? '+' : '-',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(entry['message']),
              );
            },
          );
        } else {
          // Handle loading/error states if needed
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
