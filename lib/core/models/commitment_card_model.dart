class CommitmentModel {
  String description;
  double amount;
  List<ExpenseModel> expenses;
  CommitmentModel({
    required this.description,
    required this.amount,
    required this.expenses,
  });
  CommitmentModel copyWith({
    String? description,
    double? amount,
    List<ExpenseModel>? expenses,
  }) {
    return CommitmentModel(
      description: description ?? this.description,
      amount: amount ?? this.amount,
      expenses: expenses ?? this.expenses,
    );
  }
}

class ExpenseModel {
  String description;
  double amount;
  ExpenseModel({required this.description, required this.amount});

  ExpenseModel copyWith({String? description, double? amount}) {
    return ExpenseModel(
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {description: description, 'amount': amount};
  // }

  // factory ExpenseModel.fromJson(Map<String, dynamic> json) {
  //   return ExpenseModel(
  //     description: json['description'],
  //     amount: (json['amount'] as num).toDouble(),
  //   );
  // }
}
