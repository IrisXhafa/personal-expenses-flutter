import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'widgets/transaction_creation.dart';
import 'widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  List<Transaction> transactions = [
    Transaction(
        id: '1',
        title: 'Weekly Groceries',
        amount: 16.95,
        date: DateTime.now()),
    Transaction(
      id: '2',
      title: 'Shirts',
      amount: 68.95,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return this
        .transactions
        .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  _addTransaction(String title, double amount, DateTime selectedDate) {
    Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );
    setState(() {
      transactions.add(newTransaction);
    });
  }

  _showInputArea(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionCreation(_addTransaction);
        });
  }

  _deleteTransaction(String id) {
    setState(() {
      this.transactions.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showInputArea(context),
        )
      ],
    );
    var transactionListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(this.transactions, this._deleteTransaction),
    );

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: appBar,
      body: Column(children: [
        if (!isLandscape)
          Container(
            padding: EdgeInsets.all(10),
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            child: Chart(this._recentTransactions),
          ),
        if (!isLandscape) transactionListWidget,
        if (isLandscape)
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        if (isLandscape)
          _showChart
              ? Container(
                  padding: EdgeInsets.all(10),
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(this._recentTransactions),
                )
              : transactionListWidget
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showInputArea(context),
      ),
    );
  }
}
