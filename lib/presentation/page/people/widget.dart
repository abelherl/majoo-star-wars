import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.onChanged
  }) : super(key: key);

  final String title;
  final Function(String) onChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(title),
        SizedBox(height: 5),
        TextFormField(
          onChanged: (string) => onChanged(string),
          initialValue: initialValue,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}