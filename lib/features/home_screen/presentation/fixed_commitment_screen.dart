import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/core/reusable_widgets/reusable_widget_for_home_and_detailed_screens.dart';

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
        emptyListText: 'Nothing to see yet',
        textEditingController: textEditingController,
        focusNode: focusNode,
        dynamicList: commitments,

        // EDIT
        onTap: (int index) {
          editingIndex = index;

          textEditingController.text = commitments[index].totalAmountOfMoney
              .toString();

          focusNode.requestFocus();
        },

        // DELETE
        onPressed: (int index) {
          ref.read(fixedCommitmentProvider.notifier).deleteExpenses(index);

          // If we deleted the item we were editing
          editingIndex = null;
          textEditingController.clear();
        },

        // ADD OR EDIT
        onSubmitted: (String value) {
          final amount = double.tryParse(value);

          if (amount == null) return;

          final notifier = ref.read(fixedCommitmentProvider.notifier);

          if (editingIndex != null) {
            // EDIT EXISTING COMMITMENT
            notifier.editExpenses(editingIndex!, amount);

            editingIndex = null;
          } else {
            // ADD NEW COMMITMENT
            notifier.addCommitments(amount, 'no');
          }

          textEditingController.clear();
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
