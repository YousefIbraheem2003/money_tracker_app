import 'package:simple_money_tracker/core/models/commitment_model.dart';

class ExpenseHistoryModel {
  final int year;
  final int month;
  final List<CommitmentHistoryModel> commitments;

  ExpenseHistoryModel({
    required this.year,
    required this.month,
    required this.commitments,
  });
}

class CommitmentHistoryModel {
  final String commitmentName;
  final List<ExpenseModel> expenses;

  CommitmentHistoryModel({
    required this.commitmentName,
    required this.expenses,
  });
}
