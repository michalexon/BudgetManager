import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  _AddIncomePageState createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;

    final newTransaction = TransactionModel(
      amount: amount,
      category: 'Przychód',
      description: _descriptionController.text,
      date: _selectedDate ?? DateTime.now(),
    );

    Navigator.pop(context, newTransaction);
  }

  Widget _buildAmountTextField() {
    return TextField(
      controller: _amountController,
      decoration: const InputDecoration(labelText: 'Kwota'),
      keyboardType: TextInputType.number,
      onSubmitted: (_) => _submitData(),
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      controller: _descriptionController,
      decoration: const InputDecoration(labelText: 'Opis'),
      onSubmitted: (_) => _submitData(),
    );
  }

  Widget _buildAddIncomeButton() {
    return ElevatedButton(
      onPressed: _submitData,
      child: const Text('Dodaj przychód'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj przychód'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAmountTextField(),
            _buildDescriptionTextField(),
            const SizedBox(height: 16),
            _buildAddIncomeButton(),
          ],
        ),
      ),
    );
  }
}
