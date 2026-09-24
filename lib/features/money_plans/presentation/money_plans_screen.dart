import 'package:flutter/material.dart';
import 'package:money_tracker_app/features/money_plans/models/money_plans_model.dart';
import 'package:money_tracker_app/features/money_plans/presentation/plan_cards.dart';

final List<MoneyPlansModel> moneyPlans = [
  FiftyThirtyTwentyPlan(),
  ZeroBasedPlan(),
  PayYourselfFirstPlan(),
  EnvelopeSystemPlan(),
];

class MoneyPlansScreen extends StatefulWidget {
  const MoneyPlansScreen({super.key});

  @override
  State<MoneyPlansScreen> createState() => _MoneyPlansScreenState();
}

class _MoneyPlansScreenState extends State<MoneyPlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemCount: moneyPlans.length,
        itemBuilder: (context, index) {
          final plan = moneyPlans[index];
          return PlanCards(
            moneyPlansModel: moneyPlans[index],
            isPressed: () {
              setState(() {
                moneyPlans[index] = plan.copyWith(isExpanded: !plan.isExpanded);
              });

              print('Card $index isExpanded: ${moneyPlans[index].isExpanded}');
            },
            onTap: () {
              switch (plan.planType) {
                case PlanType.fiftyThirtyTwenty:
                  print('User selected: 50/30/20 Plan');
                  final result = plan.calculatePlan(1000);
                  print(result);
                  break;

                case PlanType.zeroBased:
                  print('User selected: Zero-Based Plan');
                  break;

                case PlanType.payYourselfFirst:
                  print('User selected: Pay Yourself First Plan');
                  break;

                case PlanType.envelopeSystem:
                  print('User selected: Envelope System Plan');
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
