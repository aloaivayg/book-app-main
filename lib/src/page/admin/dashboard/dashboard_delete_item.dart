import 'package:flutter/material.dart';

class DeleteItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delete Item',
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
          ElevatedButton(
            onPressed: () {
              // Handle delete item logic
            },
            child: Text('Delete Item'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }
}
