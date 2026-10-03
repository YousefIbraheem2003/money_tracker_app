import 'package:flutter/material.dart';
import 'package:simple_money_tracker/core/reusable_widgets/reusable_card.dart';

class ReusableWidgetForHomeAndDetailedScreens extends StatelessWidget {
  const ReusableWidgetForHomeAndDetailedScreens({
    super.key,
    required this.emptyListText,
    required this.textEditingController,
    required this.focusNode,
    required this.dynamicList,
    required this.onTap,
    required this.onPressed,
    required this.onSubmitted,
    required this.category,
    required this.categoryOfTheReusableCard,
    required this.onPressedEdit,
  });

  final String emptyListText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final List<dynamic> dynamicList;
  final void Function(int index) onTap;
  final void Function(int index) onPressed;
  final ValueChanged<String> onSubmitted;
  final CommitmentCategory category;
  final Category categoryOfTheReusableCard;
  final void Function(int index) onPressedEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: dynamicList.isEmpty
                  ? Center(child: Text(emptyListText))
                  : ListView.builder(
                      itemCount: dynamicList.length,
                      itemBuilder: (context, index) {
                        return ReusableCard(
                          onPressedEdit: () {
                            onPressedEdit(index);
                          },
                          category: categoryOfTheReusableCard,
                          onPressedDelete: () {
                            onPressed(index);
                          },
                          onTap: () {
                            onTap(index);
                          },
                          description: dynamicList[index].description,
                          totalAmountOfMoney: dynamicList[index].amount,
                        );
                      },
                    ),
            ),

            const Spacer(),

            category == CommitmentCategory.commitment
                ? const SizedBox()
                : TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    onSubmitted: onSubmitted,
                    decoration: const InputDecoration(
                      hintText: 'Enter your expenses',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

enum CommitmentCategory { commitment, expense }
