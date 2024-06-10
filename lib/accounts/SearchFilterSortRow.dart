import 'package:flutter/material.dart';

class SearchFilterSortRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search in sales',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter action
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Handle sort action
            },
          ),
        ],
      ),
    );
  }
}