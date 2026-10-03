import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/core/reusable_widgets/form_reusable_widget.dart';
import 'package:simple_money_tracker/features/fixed_commitment/presentation/fixed_commitment_screen.dart';

class AddCommitment extends ConsumerWidget {
  const AddCommitment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController commitmentNameController = TextEditingController();
    TextEditingController totalAmountController = TextEditingController();

    return FormReusableWidget(
      commitmentName: commitmentNameController,
      totalAmount: totalAmountController,
      commitmentAction: 'Add Commitment',
      onSubmitted: (value) {
        final amount = double.tryParse(totalAmountController.text);
        if (amount == null) return;
        ref
            .read(fixedCommitmentProvider.notifier)
            .addCommitments(
              totalAmountOfMoney: amount,
              description: commitmentNameController.text,
            );

        totalAmountController.clear();
        commitmentNameController.clear();
      },
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FixedCommitmentScreen()),
        );
      },
    );
  }
}
