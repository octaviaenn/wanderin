import 'package:flutter/material.dart';

class Fullname extends StatefulWidget {
  //final VoidCallback onNext;
  final PageController controller;

  const Fullname({super.key, required this.controller});

  @override
  State<Fullname> createState() => _FullnameState();
}

class _FullnameState extends State<Fullname> {
  final _fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'First things first - your full name',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: TextField(
                  controller: _fullName,
                  decoration: InputDecoration(
                    hintText: 'Type your name here',
                    filled: true,
                    fillColor: Color(0xFFF8F2E9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
