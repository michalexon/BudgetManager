import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';

class AddExpensePage extends StatefulWidget {
  final List<CategoryModel> categories;

  const AddExpensePage({super.key, required this.categories});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  void _submitData() {
    if (_amountController.text.isEmpty || _selectedCategory == null) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;

    final newTransaction = TransactionModel(
      amount: -amount,
      category: _selectedCategory!,
      description: _descriptionController.text,
      date: DateTime.now(),
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

  Widget _buildCategoryDropdown() {
    return DropdownButton<String>(
      hint: const Text('Wybierz kategorię'),
      value: _selectedCategory,
      items: widget.categories.map((category) {
        return DropdownMenuItem(
          value: category.name,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      controller: _descriptionController,
      decoration: const InputDecoration(labelText: 'Opis'),
      onSubmitted: (_) => _submitData(),
    );
  }

  Widget _buildAddExpenseButton() {
    return ElevatedButton(
      onPressed: _submitData,
      child: const Text('Dodaj wydatek'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj wydatek'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAmountTextField(),
            _buildCategoryDropdown(),
            _buildDescriptionTextField(),
            const SizedBox(height: 16),
            _buildAddExpenseButton(),
          ],
        ),
      ),
    );
  }
}
