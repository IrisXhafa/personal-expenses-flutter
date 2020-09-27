import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCreation extends StatefulWidget {
  final Function addTransaction;

  TransactionCreation(this.addTransaction);

  @override
  _TransactionCreationState createState() => _TransactionCreationState();
}

class _TransactionCreationState extends State<TransactionCreation> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;

  submitData() {
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);
    final DateTime selectedDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTransaction(_titleController.text,
        double.parse(_amountController.text), selectedDate);

    Navigator.of(context).pop();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        this._selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: this._titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: this._amountController,
                onSubmitted: (_) => submitData(),
              ),
              Row(
                children: [
                  Text(
                    this._selectedDate == null
                        ? 'No date chosen'
                        : 'Selected Date: ${DateFormat.yMd().format(this._selectedDate)}',
                  ),
                  FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ))
                ],
              ),
              RaisedButton(
                onPressed: () => this.submitData(),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add transaction',
                  style: Theme.of(context).textTheme.button,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
