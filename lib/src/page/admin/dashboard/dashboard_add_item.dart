import 'dart:convert';
import 'dart:typed_data';

import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:book_app/src/config/http/http_client.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Uint8List? _selectedImage;

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  String? _selectedCategory;
  final _categories = ["T-Shirt", "Hoodie", "Jacket", "Pants", "Sweater"];
  final fields = {
    "name": "DG T-Shirt",
    "productCode": "TSH123",
    "description": "Comfortable cotton t-shirt",
    "price": 20,
    "brand": "Apparel",
    "size": "S",
    "color": "black",
    "colorHexValue": "#ffffff",
    "quantity": 10,
  };

  // Function to select an image using FilePicker
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to image files
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      setState(() {
        _selectedImage = fileBytes;
      });
    }
  }

  // Function to upload the image to the server
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an image first")),
        );
        return;
      }

      try {
        // Simulate image upload (replace with actual API call)
        final base64Image = base64Encode(_selectedImage!);

        final String url = '${ServerUrl.productApi}/create';
        // print(url);
        var body = {
          "name": _formData["name"],
          "productCode": _formData["productCode"],
          "description": _formData["description"],
          "price": double.tryParse(_formData["price"] ?? "0") ?? 0,
          "category": _formData["category"],
          "brand": _formData["brand"],
          "image": base64Image,
          "variants": {
            "size": _formData["size"],
            "color": _formData["color"],
            "colorHexValue": _formData["colorHexValue"],
            "quantity": int.tryParse(_formData["quantity"] ?? "0") ?? 0,
          }
        };

        final response = await HttpClient.postRequest(url, params: body);
        // print(jsonDecode(response["body"]));
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image uploaded successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "Code: ${response.statusCode}. Failed to create product.")),
          );
        }
      } catch (error) {
        print(error);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create product")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Item"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ..._buildFormFields(),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Category"),
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  onSaved: (value) => _formData["category"] = value!,
                  validator: (value) =>
                      value == null ? "Please select a category" : null,
                ),
                const SizedBox(height: 10),
                _selectedImage == null
                    ? Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(child: Text("No image selected")),
                      )
                    : Image.memory(
                        _selectedImage!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Upload Image"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> _buildFormFields() {
    return fields.entries.map((entry) {
      final key = entry.key; // The key of the map entry
      final value = entry.value; // The value of the map entry

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: key, // Use the key as the label
            border: const OutlineInputBorder(),
          ),
          initialValue: value.toString(), // Convert the value to a string
          onSaved: (inputValue) {
            if (inputValue != null) {
              _formData[key] = inputValue; // Save to the form data map
            }
          },
          validator: (inputValue) {
            if (inputValue == null || inputValue.isEmpty) {
              return "Please enter $key"; // Use the key in the error message
            }
            return null;
          },
        ),
      );
    }).toList();
  }
}
