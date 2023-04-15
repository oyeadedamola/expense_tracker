// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  late List<Transaction> transactions;
  final Function deleteTx;
  // final VoidCallback addNewTransaction;

  TransactionList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  "No transaction added yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 25),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(children: 
              transactions.map((tx) => TransactionnItem(
                  key: ValueKey(tx.id),
                  transaction: tx, 
                  deleteTx: deleteTx,
                  )).toList()
        
        );
           
        
  }
}
