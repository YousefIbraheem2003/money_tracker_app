import 'package:go_router/go_router.dart';
import 'package:money_tracker_app/features/home_screen/presentation/home_screen.dart';
import 'package:money_tracker_app/features/money_plans/presentation/money_plans_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => MoneyPlansScreen()),
    GoRoute(path: 'home_screen', builder: (context, state) => HomeScreen()),
  ],
);
