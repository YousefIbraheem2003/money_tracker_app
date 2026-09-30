import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/provider.dart';
import 'package:simple_money_tracker/core/reusable_widgets/reusable_widget_for_home_and_detailed_screens.dart';
import 'package:simple_money_tracker/features/home_screen/models/commitment_card_model.dart';

List<CommitmentModel> commitmentCardList = [];

class DetailedExpensesScreen extends ConsumerStatefulWidget {
  const DetailedExpensesScreen({super.key});
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
    final expenses = ref.watch(expensesProvider('Rent'));
    return SafeArea(
      child: Scaffold(
        body: ReusableWidgetForHomeAndDetailedScreens(
          emptyListText: 'Start adding your expenses',
          textEditingController: textEditingController,
          focusNode: focusNode,
          dynamicList: expenses,
          onTap: (index) {
            editingIndex = index;
            textEditingController.text = expenses[index].amount.toString();
            focusNode.requestFocus();
          },
          onPressed: (index) {
            ref.read(expensesProvider('Rent').notifier).deleteExpenses(index);
          },
          onSubmitted: (String value) {
            final amount = double.tryParse(value);

            if (amount == null) return;

            final notifier = ref.read(expensesProvider('Rent').notifier);

            if (editingIndex != null) {
              notifier.editExpenses(editingIndex!, amount);

              editingIndex = null;
            } else {
              notifier.addExpense(amount, 'Rent');
            }

            textEditingController.clear();
          },
        ),
      ),
    );
  }
}
