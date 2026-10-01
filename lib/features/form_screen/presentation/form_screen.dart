import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_money_tracker/core/providers/fixed_commitments_provider.dart';
import 'package:simple_money_tracker/features/fixed_commitment/presentation/fixed_commitment_screen.dart';

class FormScreen extends ConsumerWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController commitmentName = TextEditingController();
    final TextEditingController totalAmount = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Commitment')),
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
              onSubmitted: (value) {
                final amount = double.tryParse(totalAmount.text);
                if (amount == null) return;
                ref
                    .read(fixedCommitmentProvider.notifier)
                    .addCommitments(
                      totalAmountOfMoney: amount,
                      description: commitmentName.text,
                    );

                totalAmount.clear();
                commitmentName.clear();
              },
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // print(expenses[0].description);
                  // print(expenses[0].amount);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FixedCommitmentScreen(),
                    ),
                  );
                },
                child: Text('Finished'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
