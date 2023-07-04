import 'package:app/ViewModels/rewardItemsViewModel.dart';
import 'package:app/ViewModels/userViewModel.dart';
import 'package:app/models/rewardItem_model.dart';
import 'package:app/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RewardsItemPage extends ConsumerStatefulWidget {
  const RewardsItemPage({super.key, required this.shopID});

  final shopID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardsItemPageState();
}

class _RewardsItemPageState extends ConsumerState<RewardsItemPage> {
  int userPoints =
      500; // Example user points, you can replace it with your own logic

  @override
  Widget build(BuildContext context) {
    var storeItems = ref.watch(rewardItemProvider);
    var userDetails = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: storeItems.when(
        data: (data) {
          var filteredItems = data.docs.where((element) {
            return element.data()['rewardsShopsID'] == widget.shopID;
          }).toList();

          return userDetails.when(
            data: (userData) {
              userPoints = userData.data()!["_rewardPoints"];
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Available Points: ${userPoints}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        RewardItem rewards =
                            RewardItem.fromMap(filteredItems[index].data());

                        return GestureDetector(
                          onTap: () {
                            if (userPoints >= rewards.points) {
                              // Handle claiming the reward
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Claim Reward'),
                                    content: Text(
                                        'Are you sure you want to claim ${rewards.name}?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Claim'),
                                        onPressed: () {
                                          FirestoreService()
                                              .redeemItem(rewards.points);
                                          Fluttertoast.showToast(
                                              msg: "Item Claimed!");
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
                                    title: const Text('Insufficient Points'),
                                    content: Text(
                                        'You don\'t have enough points to claim ${rewards.name}.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
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
                              leading: Image.network(
                                rewards.image,
                                width: 60,
                                height: 60,
                              ),
                              title: Text(rewards.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rewards.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Points required: ${rewards.points}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            error: (error, stack) {
              return Center(
                child: Text('Error: $error'),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        error: (error, stack) {
          return Center(
            child: Text('Error: $error'),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
