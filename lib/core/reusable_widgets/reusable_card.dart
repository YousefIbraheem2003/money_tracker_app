import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.onTap,
    required this.description,
    required this.totalAmountOfMoney,
    required this.onPressedDelete,
    required this.category,
    required this.onPressedEdit,
  });
  final String description;
  final double totalAmountOfMoney;
  final VoidCallback onTap;
  final VoidCallback onPressedDelete;
  final VoidCallback onPressedEdit;
  final Category category;
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
            category == Category.fixedCommintmentScreen
                ? IconButton(onPressed: onPressedEdit, icon: Icon(Icons.edit))
                : const SizedBox(),
            IconButton(onPressed: onPressedDelete, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}

enum Category { detailedExpensesScreen, fixedCommintmentScreen }
