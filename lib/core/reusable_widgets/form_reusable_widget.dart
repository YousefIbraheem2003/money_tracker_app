import 'package:flutter/material.dart';

class FormReusableWidget extends StatelessWidget {
  const FormReusableWidget({
    super.key,

    required this.name,
    required this.totalAmount,
    required this.onSubmitted,
    required this.onPressed,
    required this.commitmentAction,
  });
  final String commitmentAction;
  final TextEditingController name;
  final TextEditingController totalAmount;
  final void Function(String value) onSubmitted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(commitmentAction)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text('Commitment name'),
            TextField(
              controller: name,
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
