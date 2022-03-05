import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // onChanged: (value) => titleInput = value,
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // onChanged: (value) => amountInput = value,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 9,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date chosen!'
                            : 'picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showDate();
                      },
                      child: Text(
                        _selectedDate != null ? 'Change Date' : 'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text(
                        'Add Expense',
                      ),
                      onPressed: _submitData)
                  : ElevatedButton(
                      onPressed: _submitData,
                      child: Text(
                        'Add Expense',
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.black,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
