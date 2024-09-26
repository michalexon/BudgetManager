import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  final Function(String) onAddCategory;

  const AddCategoryPage({super.key, required this.onAddCategory});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _categoryController = TextEditingController();

  void _submitCategory() {
    final categoryName = _categoryController.text;
    if (categoryName.isEmpty) return;

    widget.onAddCategory(categoryName);
    Navigator.pop(context);
  }

  Widget _buildCategoryTextField() {
    return TextField(
      controller: _categoryController,
      decoration: const InputDecoration(labelText: 'Nazwa kategorii'),
      onSubmitted: (_) => _submitCategory(),
    );
  }

  Widget _buildAddCategoryButton() {
    return ElevatedButton(
      onPressed: _submitCategory,
      child: const Text('Dodaj kategorię'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj kategorię'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCategoryTextField(),
            const SizedBox(height: 16),
            _buildAddCategoryButton(),
          ],
        ),
      ),
    );
  }
}
