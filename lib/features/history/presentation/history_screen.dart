import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/history_provider.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  DateTime? selectedDate;
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyProvider);
    final historyIndex = selectedDate == null
        ? -1
        : history.indexWhere(
            (item) =>
                item.year == selectedDate!.year &&
                item.month == selectedDate!.month,
          );

    final selectedHistory = historyIndex == -1 ? null : history[historyIndex];
    return Scaffold(
      appBar: AppBar(title: Text('Expenses History')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                _selectDate();
              },
              child: Text(
                selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'No date selected',
              ),
            ),
            selectedHistory == null
                ? Text('No expenses for this month')
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 30),
                      itemCount: selectedHistory.commitments.length,
                      itemBuilder: (context, index) {
                        final commitment = selectedHistory.commitments[index];

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(commitment.commitmentName),
                                SizedBox(height: 20),
                                Column(
                                  children: List.generate(
                                    commitment.expenses.length,
                                    (index) {
                                      final expense =
                                          commitment.expenses[index];
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(expense.description),
                                              Text(
                                                expense.amount.toStringAsFixed(
                                                  2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          index ==
                                                  commitment.expenses.length - 1
                                              ? SizedBox()
                                              : Divider(
                                                  thickness: 1,
                                                  color: Colors.black,
                                                  height: 15,
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
