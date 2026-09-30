import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/core/reusable_widgets/reusable_widget_for_home_and_detailed_screens.dart';
//

class DetailedExpensesScreen extends ConsumerStatefulWidget {
  final int index;
  const DetailedExpensesScreen({super.key, required this.index});

  @override
  ConsumerState<DetailedExpensesScreen> createState() =>
      _DetailedExpensesScreen();
}

class _DetailedExpensesScreen extends ConsumerState<DetailedExpensesScreen> {
  late TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  int? editingIndex;
  int? index;
  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(fixedCommitmentProvider);
    return SafeArea(
      child: Scaffold(
        body: ReusableWidgetForHomeAndDetailedScreens(
          emptyListText: 'Start adding your expenses',
          textEditingController: textEditingController,
          focusNode: focusNode,
          dynamicList: expenses[widget.index].expenses,
          onTap: (index) {
            editingIndex = index;
            textEditingController.text = expenses[index].amount.toString();
            focusNode.requestFocus();
          },
          onPressed: (index) {
            // ref.read(expensesProvider('Rent').notifier).deleteExpenses(index);
          },
          onSubmitted: (String value) {
            final amount = double.tryParse(value);

            if (amount == null) return;

            final notifier = ref.read(fixedCommitmentProvider.notifier);

            if (editingIndex != null) {
              // notifier.editExpenses(editingIndex!, amount);

              editingIndex = null;
            } else {
              notifier.addExpenses(
                index: widget.index,
                description: '',
                totalAmountOfMoney: double.tryParse(
                  textEditingController.text,
                )!,
              );
            }

            textEditingController.clear();
          },
        ),
      ),
    );
  }
}
