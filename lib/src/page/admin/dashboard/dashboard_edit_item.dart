import 'package:flutter/material.dart';

class EditItemScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Item',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Select Item',
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              10,
              (index) => DropdownMenuItem(
                child: Text('Item ${index + 1}'),
                value: index,
              ),
            ),
            onChanged: (value) {
              // Handle item selection
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'New Item Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle edit item logic
              }
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
