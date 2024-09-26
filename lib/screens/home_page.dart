import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';
import '../widgets/transaction_list.dart';
import 'add_category_page.dart';
import 'add_income_page.dart';
import 'add_expense_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> _transactions = [];
  final List<CategoryModel> _categories = [
    CategoryModel(name: 'Jedzenie'),
    CategoryModel(name: 'Transport'),
    CategoryModel(name: 'Rozrywka'),
  ];

  void _addTransaction(TransactionModel transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _addCategory(String categoryName) {
    setState(() {
      _categories.add(CategoryModel(name: categoryName));
    });
  }

  double get totalIncome => _transactions
      .where((transaction) => transaction.amount > 0)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);

  double get totalExpenses => _transactions
      .where((transaction) => transaction.amount < 0)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);

  double get balance => totalIncome + totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menedżer Budżetu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceInfo(),
            const SizedBox(height: 24),
            Expanded(
              child: TransactionList(transactions: _transactions),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBalanceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aktualny bilans',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              balance.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 32,
                color: balance >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'zł',
              style: TextStyle(
                fontSize: 32,
                color: balance >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildIncomeExpenseInfo(),
      ],
    );
  }

  Widget _buildIncomeExpenseInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIncomeInfo(),
        _buildExpenseInfo(),
      ],
    );
  }

  Widget _buildIncomeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Całkowite przychody',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              totalIncome.toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, color: Colors.green),
            ),
            const SizedBox(width: 8),
            const Text(
              'zł',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpenseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Całkowite wydatki',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              totalExpenses.abs().toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, color: Colors.red),
            ),
            const SizedBox(width: 8),
            const Text(
              'zł',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  BottomAppBar _buildBottomNavigationBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavButton(Icons.attach_money, _addIncome),
          _buildBottomNavButton(Icons.money_off, _addExpense),
          _buildBottomNavButton(Icons.category, _addCategoryPage),
        ],
      ),
    );
  }

  IconButton _buildBottomNavButton(IconData icon, Function onPressed) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () async {
        final result = await onPressed();
        if (result != null) {
          _addTransaction(result);
        }
      },
    );
  }

  Future<TransactionModel?> _addIncome() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddIncomePage()),
    );
  }

  Future<TransactionModel?> _addExpense() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpensePage(categories: _categories),
      ),
    );
  }

  Future<void> _addCategoryPage() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCategoryPage(onAddCategory: _addCategory),
      ),
    );
  }
}
