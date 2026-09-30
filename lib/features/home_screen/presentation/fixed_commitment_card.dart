import 'package:flutter/material.dart';
import 'package:simple_money_tracker/features/home_screen/models/commitment_card_model.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.commitmentCardModel,
    required this.onTap,
  });
  final CommitmentModel commitmentCardModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(commitmentCardModel.description),
            Text('${commitmentCardModel.totalAmountOfMoney}'),
          ],
        ),
      ),
    );
  }
}
