import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.description),
          subtitle: Text(transaction.category),
          trailing: Text(
            '${transaction.amount > 0 ? '+' : ''}${transaction.amount.toStringAsFixed(2)} zł',
            style: TextStyle(
              color: transaction.amount > 0 ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }
}
