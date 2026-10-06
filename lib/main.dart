import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/features/dash_doard/presentation/dash_board_screen.dart';

void main() {
  runApp(ProviderScope(child: SimpleMoneyTracker()));
}

class SimpleMoneyTracker extends StatelessWidget {
  const SimpleMoneyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashBoardScreen(),
    );
  }
}
