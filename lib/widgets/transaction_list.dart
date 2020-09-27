import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

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
            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 8,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('\$${this.transactions[index].amount}'),
                    ),
                  ),
                ),
                title: Text(this.transactions[index].title),
                subtitle: Text(DateFormat.yMMMd()
                    .format(transactions[index].date)
                    .toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () =>
                      this.deleteTransaction(transactions[index].id),
                ),
              ),
            );
          },
          itemCount: transactions.length,
        ),
      );
    });
  }
}
