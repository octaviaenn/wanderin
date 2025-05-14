import 'package:flutter/material.dart';

class Destination extends StatefulWidget {
  //final VoidCallback onNext;
  final PageController controller;

  const Destination({super.key, required this.controller});

  @override
  State<Destination> createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  final List<String> destinations = [
    'Beach',
    'Mountain',
    'Lake',
    'Forest',
    'Safari',
    'Island',
    'Culture',
    'City',
    'Historical',
    'Sport',
    'Culinary',
    'Diving',
    'City',
    'Diving',
    'City',
  ];

  final Set<String> selected = {};

  void _onSelect(String destination) {
    setState(() {
      if (selected.contains(destination)) {
        selected.remove(destination);
      } else {
        if (selected.length < 3) {
          selected.add(destination);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              const Text(
                "Let's make it perfect. Which type of destination calls to you?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: destinations.map((destination) {
                  final isSelected = selected.contains(destination);
                  return ChoiceChip(
                    label: Text(destination),
                    selected: isSelected,
                    onSelected: (_) => _onSelect(destination),
                    selectedColor: Color(0xFF505D7D),
                    backgroundColor: Color(0xFFF8F2E9),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(color: Color(0xFF505D7D), width: 2),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              const Text(
                "Pick three option!",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
