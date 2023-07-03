import 'package:flutter/material.dart';

class RewardItem {
  final String name;
  final String description;
  final int points;
  final String imagePath;

  RewardItem({
    required this.name,
    required this.description,
    required this.points,
    required this.imagePath,
  });
}

class RewardsItemPage extends StatefulWidget {
  @override
  _RewardsItemPageState createState() => _RewardsItemPageState();
}

class _RewardsItemPageState extends State<RewardsItemPage> {
  List<RewardItem> rewards = [
    RewardItem(
      name: 'Item 1',
      description: 'Description of Item 1',
      points: 100,
      imagePath: 'assets/drinks.png',
    ),
    RewardItem(
      name: 'Item 2',
      description: 'Description of Item 2',
      points: 200,
      imagePath: 'assets/desserts.png',
    ),
    RewardItem(
      name: 'Item 3',
      description: 'Description of Item 3',
      points: 300,
      imagePath: 'assets/crown.png',
    ),
    // Add more reward items as needed
  ];

  int userPoints = 500; // Example user points, you can replace it with your own logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Available Points: $userPoints',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (userPoints >= rewards[index].points) {
                      // Handle claiming the reward
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Claim Reward'),
                            content: Text(
                                'Are you sure you want to claim ${rewards[index].name}?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Claim'),
                                onPressed: () {
                                  // Deduct the points and update the user's points
                                  setState(() {
                                    userPoints -= rewards[index].points;
                                  });
                                  Navigator.of(context).pop();
                                  // Show a success message or perform other actions
                                  // related to claiming the reward
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Show an error message or perform other actions
                      // if the user doesn't have enough points to claim the reward
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Insufficient Points'),
                            content: Text(
                                'You don\'t have enough points to claim ${rewards[index].name}.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(
                        rewards[index].imagePath,
                        width: 60,
                        height: 60,
                      ),
                      title: Text(rewards[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rewards[index].description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Points required: ${rewards[index].points}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
