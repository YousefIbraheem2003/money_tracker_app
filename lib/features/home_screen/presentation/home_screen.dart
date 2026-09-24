import 'package:flutter/material.dart';
import 'package:money_tracker_app/features/home_screen/models/home_screen_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.homeScreenModel});
  final HomeScreenModel homeScreenModel;
  @override
  Widget build(BuildContext context) {
    final breakdownEntries = homeScreenModel.planSummary.entries.toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(homeScreenModel.planName),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: breakdownEntries.length,
                itemBuilder: (context, index) {
                  final entry = breakdownEntries[index];
                  return Card(
                    child: Column(
                      children: [Text(entry.key), Text('${entry.value}')],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
