import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/models/commitment_model.dart';
import 'package:simple_money_tracker/core/storage_helper/storage_helper.dart';

final fixedCommitmentProvider =
    NotifierProvider<FixedCommitmentNotifier, List<CommitmentModel>>(
      FixedCommitmentNotifier.new,
    );

class FixedCommitmentNotifier extends Notifier<List<CommitmentModel>> {
  @override
  List<CommitmentModel> build() {
    print('BUILD PROVIDER');
    _loadCommitments();

    return [];
  }

  void addCommitments({
    required double totalAmountOfMoney,
    required String description,
  }) {
    // final expenses = ref.read(expensesProvider(description));

    final newCommitmmitmentsModel = CommitmentModel(
      dateTime: DateTime.now(),
      description: description,
      amount: totalAmountOfMoney,
      originalAmount: totalAmountOfMoney,
      expenses: [],
    );
    state = [...state, newCommitmmitmentsModel];
    StorageHelper.saveCommitments(state);
  }

  void addExpenses({
    required int index,
    required double totalAmountOfMoney,
    required String description,
  }) {
    final newExpenses = ExpenseModel(
      dateTime: DateTime.now(),
      description: description,
      amount: totalAmountOfMoney,
    );
    final commitment = state[index];
    final newTotalAmountOfMoney = commitment.amount - newExpenses.amount;
    final newExpesesList = [...commitment.expenses, newExpenses];

    final updatedCommitment = commitment.copyWith(
      expenses: newExpesesList,
      amount: newTotalAmountOfMoney,
    );
    final newState = [...state];
    newState[index] = updatedCommitment;
    state = newState;
    StorageHelper.saveCommitments(state);
  }

  void deleteCommitment(int index) {
    final newCommitment = [...state];
    newCommitment.removeAt(index);
    state = newCommitment;
    StorageHelper.saveCommitments(state);
  }

  void deleteExpenses({
    required int indexOfTheCommitment,
    required int indexOfTheFixedCommitment,
  }) {
    final commitment = state[indexOfTheCommitment];
    final newExpensesList = [...commitment.expenses];
    final newTotalAmountOfMoney =
        newExpensesList[indexOfTheFixedCommitment].amount + commitment.amount;
    newExpensesList.removeAt(indexOfTheFixedCommitment);
    final updatedCommitment = commitment.copyWith(
      expenses: newExpensesList,
      amount: newTotalAmountOfMoney,
    );
    final newState = [...state];
    newState[indexOfTheCommitment] = updatedCommitment;
    state = newState;
    StorageHelper.saveCommitments(state);
  }

  void editCommitment({
    required int index,
    required double? amount,
    required String description,
  }) {
    final newCommitment = state[index];
    final updatedExpensesList = newCommitment.expenses
        .map((expense) => expense.copyWith(description: description))
        .toList();

    final updatedCommitment = newCommitment.copyWith(
      amount: amount,
      description: description,
      expenses: updatedExpensesList,
    );

    final newList = [...state];
    newList[index] = updatedCommitment;
    state = newList;
    StorageHelper.saveCommitments(state);
  }

  void editExpenses({
    required int indexOfTheCommitment,
    required int indexOfTheFixedCommitment,
    required double amount,
  }) {
    final newCommitment = state[indexOfTheCommitment];
    final newExpense = newCommitment.expenses[indexOfTheFixedCommitment];
    final updatedExpense = newExpense.copyWith(amount: amount);
    final updatedExpenses = [...newCommitment.expenses];
    updatedExpenses[indexOfTheFixedCommitment] = updatedExpense;
    final updatedCommitment = newCommitment.copyWith(expenses: updatedExpenses);
    final newState = [...state];
    newState[indexOfTheCommitment] = updatedCommitment;
    state = newState;
    StorageHelper.saveCommitments(state);
  }

  Future<void> _loadCommitments() async {
    print('start loading');
    final commitments = await StorageHelper.loadCommitments();
    print('LOADED COMMITMENTS: ${commitments.length}');
    state = commitments;
    print('STATE UPDATED: ${state.length}');
  }
}
