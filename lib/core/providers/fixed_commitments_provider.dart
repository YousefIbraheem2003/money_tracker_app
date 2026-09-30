import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/models/commitment_card_model.dart';

final fixedCommitmentProvider =
    NotifierProvider<FixedCommitmentNotifier, List<CommitmentModel>>(
      FixedCommitmentNotifier.new,
    );

class FixedCommitmentNotifier extends Notifier<List<CommitmentModel>> {
  @override
  List<CommitmentModel> build() {
    return [];
  }

  void addCommitments(double totalAmountOfMoney, String description) {
    // final expenses = ref.read(expensesProvider(description));

    final newCommitmmitmentsModel = CommitmentModel(
      description: description,
      amount: totalAmountOfMoney,
      expenses: [],
    );
    state = [...state, newCommitmmitmentsModel];
  }

  void addExpenses({
    required int index,
    required double totalAmountOfMoney,
    required String description,
  }) {
    final newExpenses = ExpenseModel(
      description: description,
      amount: totalAmountOfMoney,
    );
    final commitment = state[index];
    final newExpesesList = [...commitment.expenses, newExpenses];
    final updatedCommitment = commitment.copyWith(expenses: newExpesesList);
    final newState = [...state];
    newState[index] = updatedCommitment;
    state = newState;
  }

  void deleteExpenses(int index) {
    final newExpense = [...state];
    newExpense.removeAt(index);
    state = newExpense;
  }

  // void editExpenses(int index, double? amount) {
  //   final oldExpense = state[index];
  //   final updatedExpense = oldExpense.copyWith(totalAmountOfMoney: amount);
  //   final newList = [...state];
  //   newList[index] = updatedExpense;
  //   state = newList;
  // }
}
