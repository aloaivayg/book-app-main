import 'package:flutter/material.dart';

class FilterDropdowns extends StatelessWidget {
  final List<String> filterOptions;

  const FilterDropdowns({Key? key, required this.filterOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon button for filter
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune),
          ),
          const SizedBox(width: 8.0),

          // Dropdown buttons
          Row(
            children: filterOptions.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    value: option,
                    underline: const SizedBox(), // Remove underline
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: [option]
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
