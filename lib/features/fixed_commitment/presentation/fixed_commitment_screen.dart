import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/core/reusable_widgets/reusable_widget_for_home_and_detailed_screens.dart';
import 'package:simple_money_tracker/features/detailed_expenses_Screen/detailed_expenses_screen.dart';

class FixedCommitmentScreen extends ConsumerStatefulWidget {
  const FixedCommitmentScreen({super.key});

  @override
  ConsumerState<FixedCommitmentScreen> createState() =>
      _FixedCommitmentScreenState();
}

class _FixedCommitmentScreenState extends ConsumerState<FixedCommitmentScreen> {
  final TextEditingController textEditingController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  int? editingIndex;

  @override
  Widget build(BuildContext context) {
    final commitments = ref.watch(fixedCommitmentProvider);

    return Scaffold(
      body: ReusableWidgetForHomeAndDetailedScreens(
        category: CommitmentCategory.commitment,
        emptyListText: 'Nothing to see yet',
        textEditingController: textEditingController,
        focusNode: focusNode,
        dynamicList: commitments,

        onTap: (int index) {
          print(index);
          // print(commitments[index].expenses[index].amount);
          // print(commitments[index].expenses[index].description);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedExpensesScreen(index: index),
            ),
          );
          // editingIndex = index;

          // textEditingController.text = commitments[index].amount.toString();

          // focusNode.requestFocus();
        },

        onPressed: (int index) {
          ref.read(fixedCommitmentProvider.notifier).deleteCommitment(index);

          editingIndex = null;
          textEditingController.clear();
        },

        // ADD OR EDIT
        onSubmitted: (String value) {
          // final amount = double.tryParse(value);

          // if (amount == null) return;

          // final notifier = ref.read(fixedCommitmentProvider.notifier);

          // if (editingIndex != null) {
          //   // EDIT EXISTING COMMITMENT
          //   // notifier.editExpenses(editingIndex!, amount);

          //   editingIndex = null;
          // } else {
          //   notifier.addCommitments(
          //     totalAmountOfMoney: amount,
          //     description: 'no',
          //   );
          // }

          // textEditingController.clear();
        },
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
