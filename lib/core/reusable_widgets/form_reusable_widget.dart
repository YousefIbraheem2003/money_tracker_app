import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormScreen extends ConsumerWidget {
  const FormScreen({
    super.key,
    required this.commitmentName,
    required this.totalAmount,
    required this.commitmentAction,
    required this.onSubmitted,
    required this.onPressed,
  });
  final TextEditingController commitmentName;
  final TextEditingController totalAmount;
  final CommitmentAction commitmentAction;
  final void Function(String value) onSubmitted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: commitmentAction == CommitmentAction.addCommitment
            ? const Text('Add Commitment')
            : const Text('Edit Commitment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text('Commitment name'),
            TextField(
              controller: commitmentName,
              decoration: InputDecoration(hintText: 'Rent'),
            ),
            const SizedBox(height: 15),

            Text('Total amount'),
            TextField(
              controller: totalAmount,
              decoration: InputDecoration(hintText: '0.00'),
              onSubmitted: onSubmitted,
              // onSubmitted: (value) {
              //   final amount = double.tryParse(totalAmount.text);
              //   if (amount == null) return;
              //   ref
              //       .read(fixedCommitmentProvider.notifier)
              //       .addCommitments(
              //         totalAmountOfMoney: amount,
              //         description: commitmentName.text,
              //       );

              //   totalAmount.clear();
              //   commitmentName.clear();
              // },
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                // onPressed: () {
                //   // print(expenses[0].description);
                //   // print(expenses[0].amount);
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => FixedCommitmentScreen(),
                //     ),
                //   );
                // },
                child: Text('Finished'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CommitmentAction { addCommitment, editCommitment }
