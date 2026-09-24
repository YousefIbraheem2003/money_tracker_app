import 'package:flutter/material.dart';
import 'package:money_tracker_app/features/money_plans/models/money_plans_model.dart';

class PlanCards extends StatelessWidget {
  const PlanCards({
    super.key,
    required this.moneyPlansModel,
    required this.isPressed,
    required this.onTap,
  });
  final MoneyPlansModel moneyPlansModel;
  final VoidCallback isPressed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(moneyPlansModel.planName),
            Row(
              children: [
                Expanded(
                  child: moneyPlansModel.isExpanded == false
                      ? const Text('Info')
                      : Text(moneyPlansModel.planInfo),
                ),
                IconButton(
                  onPressed: isPressed,
                  icon: Icon(
                    moneyPlansModel.isExpanded == false
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
