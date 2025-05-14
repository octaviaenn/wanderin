import 'package:flutter/material.dart';

class Countries extends StatefulWidget {
  //final VoidCallback onNext;
  final PageController controller;

  const Countries({super.key, required this.controller});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  List<String> _options = [
    'Country 1',
    'Country 2',
    'Country 3',
    'Country 4',
    'Country 5',
    'Country 6',
    'Country 7',
    'Country 8',
  ];
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[100], // debug
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where are you from?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _options.contains(_selectedOption) ? _selectedOption : null,
            hint: Text('Select a country'),
            items: _options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
