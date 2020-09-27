import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double amountAsPercentage;

  ChartBar(this.label, this.amount, this.amountAsPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contraints) {
      return Column(
        children: [
          Container(
            height: contraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${this.amount}'),
            ),
          ),
          SizedBox(
            height: contraints.maxHeight * 0.05,
          ),
          Container(
            height: contraints.maxHeight * 0.6,
            width: 40,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: amountAsPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: contraints.maxHeight * 0.05,
          ),
          Container(
            height: contraints.maxHeight * 0.15,
            child: Text(this.label),
          )
        ],
      );
    });
  }
}
