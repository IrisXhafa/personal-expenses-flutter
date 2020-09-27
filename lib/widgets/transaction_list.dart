import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contrainsts) {
      return Container(
        height: contrainsts.maxHeight,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return TransactionItem(
                transaction: transactions[index],
                deleteTransaction: deleteTransaction);
          },
          itemCount: transactions.length,
        ),
      );
    });
  }
}
