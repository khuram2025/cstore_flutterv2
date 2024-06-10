import 'package:flutter/material.dart';

class SearchFilterSortRow extends StatelessWidget {
  final String hintText;

  SearchFilterSortRow({required this.hintText});

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
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
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