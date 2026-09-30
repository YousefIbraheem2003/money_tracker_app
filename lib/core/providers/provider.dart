import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/features/home_screen/models/commitment_card_model.dart';

final expensesProvider =
    NotifierProvider.family<ExpensesNotifier, List<ExpenseModel>, String>(
      ExpensesNotifier.new,
    );

class ExpensesNotifier extends Notifier<List<ExpenseModel>> {
  ExpensesNotifier(this.sectionName);

  final String sectionName;

  @override
  List<ExpenseModel> build() {
    return [];
  }

  void addExpense(double amount, String description) {
    final newExpense = ExpenseModel(description: description, amount: amount);

    state = [...state, newExpense];
  }

  void deleteExpenses(int index) {
    final newExpense = [...state];
    newExpense.removeAt(index);
    state = newExpense;
  }

  void editExpenses(int index, double? amount) {
    final oldExpense = state[index];
    final updatedExpense = oldExpense.copyWith(amount: amount);
    final newList = [...state];
    newList[index] = updatedExpense;
    state = newList;
  }
}
