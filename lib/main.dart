import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/features/home_screen/presentation/fixed_commitment_screen.dart';

void main() {
  runApp(ProviderScope(child: SimpleMoneyTracker()));
}

class SimpleMoneyTracker extends StatelessWidget {
  const SimpleMoneyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FixedCommitmentScreen(),
    );
  }
}
