import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/features/home_screen/models/commitment_card_model.dart';

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
      totalAmountOfMoney: totalAmountOfMoney,
      // expenses: expenses,
    );
    state = [...state, newCommitmmitmentsModel];
  }

  void deleteExpenses(int index) {
    final newExpense = [...state];
    newExpense.removeAt(index);
    state = newExpense;
  }

  void editExpenses(int index, double? amount) {
    final oldExpense = state[index];
    final updatedExpense = oldExpense.copyWith(totalAmountOfMoney: amount);
    final newList = [...state];
    newList[index] = updatedExpense;
    state = newList;
  }
}
