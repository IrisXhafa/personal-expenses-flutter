import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/models/transactionByDay.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final transactions;

  Chart(this.transactions);

  List<TransactionByDay> get groupedTransactions {
    return List.generate(7, (index) {
      final DateTime date = DateTime.now().subtract(Duration(days: index));
      double subTotal = 0.0;
      for (Transaction tx in transactions) {
        if (tx.date.day == date.day &&
            tx.date.month == date.month &&
            tx.date.year == date.year) {
          subTotal += tx.amount;
        }
      }
      return TransactionByDay(DateFormat.E().format(date), subTotal);
    }).reversed.toList();
  }

  double get totalAmountSpentOnLastWeek {
    return this.groupedTransactions.fold(0.0, (totalSum, item) {
      return totalSum += item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.transactions);
    return Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this.groupedTransactions.map((tx) {
              return LayoutBuilder(builder: (ctx, constraint) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Container(
                        height: constraint.maxHeight,
                        child: ChartBar(
                          tx.day.substring(0, 1),
                          tx.amount,
                          tx.amount / totalAmountSpentOnLastWeek,
                        ),
                      )
                    ],
                  ),
                );
              });
            }).toList(),
          ),
        ));
  }
}
