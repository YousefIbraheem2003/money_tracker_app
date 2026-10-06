import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/features/detailed_expenses_Screen/detailed_expenses_screen.dart';
import 'package:simple_money_tracker/features/fixed_commitment/presentation/add_commitment_screen.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commitment = ref.watch(fixedCommitmentProvider);

    double calculateTotalAmountOfMoney() {
      double totalAmount = 0;
      for (int i = 0; i < commitment.length; i++) {
        totalAmount = commitment[i].amount + totalAmount;
      }
      return totalAmount;
    }

    double calculateTotalAmountOfSpentMoney() {
      double totalAmountOfMoney = 0;
      for (int i = 0; i < commitment.length; i++) {
        for (int j = 0; j < commitment[i].expenses.length; j++) {
          totalAmountOfMoney =
              commitment[i].expenses[j].amount + totalAmountOfMoney;
        }
      }
      print('totalAmountOfSpentMoney:$totalAmountOfMoney ');
      return totalAmountOfMoney;
    }

    double calculateThePercentageOfTheIndicator(
      double theSpentAmount,
      double totalAmount,
    ) {
      if (totalAmount == 0) {
        return 0;
      }

      final double thePercentage = theSpentAmount / totalAmount;
      print('the percentage $thePercentage');
      print('the total Amount: $totalAmount');
      print('the spent AMOUNT $theSpentAmount');

      return thePercentage;
    }

    double totalExpensesInEveryCommitment(int index) {
      double totalAmountOfMoney = 0;
      for (int i = 0; i < commitment[index].expenses.length; i++) {
        totalAmountOfMoney =
            commitment[index].expenses[i].amount + totalAmountOfMoney;
      }
      return totalAmountOfMoney;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good afternoon'),
                SizedBox(height: 5),
                Text('dateTime'),
                SizedBox(height: 20),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Remaining'),
                        Text(
                          '${calculateTotalAmountOfMoney() - calculateTotalAmountOfSpentMoney()}',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Budget'),
                            Text('${calculateTotalAmountOfMoney()}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('spent'),
                            Text('${calculateTotalAmountOfSpentMoney()}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Commitments'),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCommitment(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                commitment.isEmpty
                    ? Text('Start adding your commitments')
                    : SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: commitment.length,
                          itemBuilder: (context, index) {
                            final percentage =
                                calculateThePercentageOfTheIndicator(
                                  totalExpensesInEveryCommitment(index),
                                  commitment[index].amount,
                                );
                            print('percentage: $percentage of index $index');
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailedExpensesScreen(index: index),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(commitment[index].description),
                                          Text('${commitment[index].amount}'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: LinearProgressIndicator(
                                              value: percentage,
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          Text(
                                            '${(percentage * 100).toStringAsFixed(0)}%',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(height: 10),
                Text('Recent Expenses'),
                SizedBox(height: 10),
                Column(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Expense'),
                          Text('totalamount of expense'),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
