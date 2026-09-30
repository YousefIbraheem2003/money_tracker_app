import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.onTap,
    required this.description,
    required this.totalAmountOfMoney,
    required this.onPressed,
  });
  final String description;
  final double totalAmountOfMoney;
  final VoidCallback onTap;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(description), Text('$totalAmountOfMoney')],
            ),
            Spacer(),
            IconButton(onPressed: onPressed, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
