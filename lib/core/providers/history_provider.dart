import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/models/commitment_model.dart';
import 'package:simple_money_tracker/features/history/models/history_model.dart';

final historyProvider =
    NotifierProvider<ExpenseHistoryNotifier, List<ExpenseHistoryModel>>(
      ExpenseHistoryNotifier.new,
    );

class ExpenseHistoryNotifier extends Notifier<List<ExpenseHistoryModel>> {
  @override
  List<ExpenseHistoryModel> build() {
    return [];
  }

  void addToTheExpensesHistory({
    required ExpenseModel expense,
    required String commitmentName,
  }) {
    final year = expense.dateTime.year;
    final month = expense.dateTime.month;

    final monthIndex = state.indexWhere(
      (history) => history.year == year && history.month == month,
    );

    if (monthIndex == -1) {
      state = [
        ...state,
        ExpenseHistoryModel(
          year: year,
          month: month,
          commitments: [
            CommitmentHistoryModel(
              commitmentName: commitmentName,
              expenses: [expense],
            ),
          ],
        ),
      ];

      return;
    }

    final monthHistory = state[monthIndex];

    final commitmentIndex = monthHistory.commitments.indexWhere(
      (commitment) => commitment.commitmentName == commitmentName,
    );

    if (commitmentIndex == -1) {
      final updatedCommitments = [
        ...monthHistory.commitments,
        CommitmentHistoryModel(
          commitmentName: commitmentName,
          expenses: [expense],
        ),
      ];

      final updatedMonth = ExpenseHistoryModel(
        year: monthHistory.year,
        month: monthHistory.month,
        commitments: updatedCommitments,
      );

      final updatedHistory = [...state];
      updatedHistory[monthIndex] = updatedMonth;

      state = updatedHistory;

      return;
    }

    final existingCommitment = monthHistory.commitments[commitmentIndex];

    final updatedCommitment = CommitmentHistoryModel(
      commitmentName: existingCommitment.commitmentName,
      expenses: [...existingCommitment.expenses, expense],
    );

    final updatedCommitments = [...monthHistory.commitments];
    updatedCommitments[commitmentIndex] = updatedCommitment;

    final updatedMonth = ExpenseHistoryModel(
      year: monthHistory.year,
      month: monthHistory.month,
      commitments: updatedCommitments,
    );

    final updatedHistory = [...state];
    updatedHistory[monthIndex] = updatedMonth;

    state = updatedHistory;
  }
}
