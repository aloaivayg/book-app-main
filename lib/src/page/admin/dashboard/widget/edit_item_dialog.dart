import 'dart:typed_data';

import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/config/http/http_client.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class EditItemDialog extends StatefulWidget {
  final Clothes clothes;
  final Function(Clothes) onSave;

  const EditItemDialog({Key? key, required this.clothes, required this.onSave})
      : super(key: key);

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _editedData;

  @override
  void initState() {
    super.initState();
    _editedData = {
      "variantCode": widget.clothes.variantCode,
      "name": widget.clothes.name,
      "productCode": widget.clothes.productCode,
      "description": widget.clothes.description,
      "price": widget.clothes.price,
      "category": widget.clothes.category,
      "brand": widget.clothes.brand,
      "size": widget.clothes.size,
      "color": widget.clothes.color,
      "colorHexValue": widget.clothes.colorHexValue,
      "quantity": widget.clothes.quantity,
    };
  }

  Future<void> _updateProduct() async {
    final String url = '${ServerUrl.productApi}/update';

    try {
      final response = await HttpClient.postRequest(url, params: _editedData);

      if (response.statusCode == 200) {
        final updatedProduct = Clothes.fromJson(json.decode(response.body));
        widget.onSave(updatedProduct); // Pass updated product back to parent
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Updated product successfully")),
        );
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Edit Item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ..._buildFormFields(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _updateProduct(); // API call to update product
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return _editedData.entries.map((entry) {
      if (entry.key == "variantCode")
        return const SizedBox(); // Skip variantCode
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          initialValue: entry.value.toString(),
          decoration: InputDecoration(
            labelText: entry.key.capitalize(),
            border: const OutlineInputBorder(),
          ),
          keyboardType: _getKeyboardType(entry.key),
          onSaved: (value) {
            if (value != null) {
              _editedData[entry.key] = _parseValue(entry.key, value);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter ${entry.key.capitalize()}";
            }
            return null;
          },
        ),
      );
    }).toList();
  }

  TextInputType _getKeyboardType(String key) {
    switch (key) {
      case "price":
      case "quantity":
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  dynamic _parseValue(String key, String value) {
    if (key == "price" || key == "quantity") {
      return int.tryParse(value) ?? double.tryParse(value) ?? value;
    }
    return value;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
