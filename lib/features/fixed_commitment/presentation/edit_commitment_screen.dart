import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/core/reusable_widgets/form_reusable_widget.dart';
import 'package:simple_money_tracker/features/fixed_commitment/presentation/fixed_commitment_screen.dart';

class EditCommitmentsScreen extends ConsumerWidget {
  const EditCommitmentsScreen({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameOfTheCommitmentController =
        TextEditingController();
    TextEditingController totalAmountOfMoneyController =
        TextEditingController();

    return FormReusableWidget(
      name: nameOfTheCommitmentController,
      totalAmount: totalAmountOfMoneyController,
      onSubmitted: (value) {},
      onPressed: () {
        double totalAmountOfMoney = double.tryParse(
          totalAmountOfMoneyController.text,
        )!;
        ref
            .read(fixedCommitmentProvider.notifier)
            .editCommitment(
              index: index,
              amount: totalAmountOfMoney,
              description: nameOfTheCommitmentController.text,
            );
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FixedCommitmentScreen()),
        );
      },

      commitmentAction: 'Edit Commitment',
    );
  }
}
