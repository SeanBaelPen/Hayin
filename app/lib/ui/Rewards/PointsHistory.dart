import 'package:flutter/material.dart';

class PointsHistoryPage extends StatefulWidget {
  const PointsHistoryPage({Key? key}) : super(key: key);

  @override
  State<PointsHistoryPage> createState() => _PointsHistoryPageState();
}

class _PointsHistoryPageState extends State<PointsHistoryPage> {
  List<PointsEntry> pointsHistory = [
    PointsEntry('Earned 10 points', DateTime(2023, 7, 10)),
    PointsEntry('Redeemed 5 points', DateTime(2023, 7, 15)),
    PointsEntry('Earned 20 points', DateTime(2023, 7, 17)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points History'),
        backgroundColor: Colors.deepOrange,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        itemCount: pointsHistory.length,
        itemBuilder: (context, index) {
          final entry = pointsHistory[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: Text(
                entry.pointsChange > 0 ? '+' : '-',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(entry.description),
            subtitle: Text(
              '${entry.date.year}-${entry.date.month.toString().padLeft(2, '0')}-${entry.date.day.toString().padLeft(2, '0')}', //for date
            ),
          );
        },
      ),
    );
  }
}

class PointsEntry {
  final String description;
  final DateTime date;

  PointsEntry(this.description, this.date);

  int get pointsChange {
    if (description.startsWith('Earned')) {
      return int.parse(description.split(' ')[1]);
    } else if (description.startsWith('Redeemed')) {
      return -int.parse(description.split(' ')[1]);
    }
    return 0;
  }
}
