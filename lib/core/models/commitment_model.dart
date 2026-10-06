class CommitmentModel {
  String description;
  double amount;
  double originalAmount;
  List<ExpenseModel> expenses;
  String dateTime;

  CommitmentModel({
    required this.originalAmount,
    required this.dateTime,
    required this.description,
    required this.amount,
    required this.expenses,
  });
  CommitmentModel copyWith({
    String? dateTime,
    String? description,
    double? amount,
    List<ExpenseModel>? expenses,
    double? originalAmount,
  }) {
    return CommitmentModel(
      originalAmount: originalAmount ?? this.originalAmount,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      expenses: expenses ?? this.expenses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'expenses': expenses.map((expense) => expense.toJson()).toList(),
      'dateTime': dateTime,
      'originalAmount': originalAmount,
    };
  }

  factory CommitmentModel.fromJson(Map<String, dynamic> json) {
    return CommitmentModel(
      originalAmount: json['originalAmount'] != null
          ? (json['originalAmount'] as num).toDouble()
          : (json['amount'] as num).toDouble(),
      dateTime: json['dateTime'] != null
          ? (json['dateTime'])
          : '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
      description: json['description'],
      amount: json['amount'],
      expenses: (json['expenses'] as List)
          .map((expense) => ExpenseModel.fromJson(expense))
          .toList(),
    );
  }
}

class ExpenseModel {
  String description;
  double amount;
  String dateTime;
  ExpenseModel({
    required this.description,
    required this.amount,
    required this.dateTime,
  });

  ExpenseModel copyWith({
    String? description,
    double? amount,
    String? dateTime,
  }) {
    return ExpenseModel(
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'amount': amount, 'dateTime': dateTime};
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      dateTime: json['dateTime'] != null
          ? (json['dateTime'])
          : '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
      description: json['description'],
      amount: json['amount'],
    );
  }
}
