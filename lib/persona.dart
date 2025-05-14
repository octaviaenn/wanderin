import 'dart:html';

import 'package:flutter/material.dart';
import 'package:wanderin/personal/countries.dart';
import 'package:wanderin/personal/destinations.dart';
import 'package:wanderin/personal/fullname.dart';
import 'package:wanderin/personal/location.dart';

class Persona extends StatefulWidget {
  const Persona({super.key});

  @override
  State<Persona> createState() => _PersonaState();
}

class _PersonaState extends State<Persona> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  late List<Map<String, dynamic>> page;

  @override
  void initState() {
    super.initState();
    page = [
      {
        'widget': Fullname(controller: _controller),
        'color': [
          Color(0xFF505D7D),
          Color(0xFFED7061),
          Color(0xFFED7061),
          Color(0xFF4DB6AC),
          Color(0xFF4DB6AC),
        ],
      },
      {
        'widget': Location(controller: _controller),
        'color': [
          Color(0xFFED7061),
          Color(0xFF505D7D),
          Color(0xFFED7061),
          Color(0xFF4DB6AC),
          Color(0xFF4DB6AC),
        ],
      },
      {
        'widget': Countries(controller: _controller),
        'color': [
          Color(0xFFED7061),
          Color(0xFFED7061),
          Color(0xFF505D7D),
          Color(0xFF4DB6AC),
          Color(0xFF4DB6AC),
        ],
      },
      {
        'widget': Destination(controller: _controller),
        'color': [
          Color(0xFFED7061),
          Color(0xFFED7061),
          Color(0xFF4DB6AC),
          Color(0xFF505D7D),
          Color(0xFF4DB6AC),
        ],
      },
      {
        'widget': SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(
              'Perfect! We\'ve got you. Now, let\'s get\n you started',
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        'color': [
          Color(0xFFED7061),
          Color(0xFFED7061),
          Color(0xFF4DB6AC),
          Color(0xFF4DB6AC),
          Color(0xFF505D7D),
        ],
      },
    ];
  }

  void _nextPage() {
    if (_currentPage < 5) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/authentication');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: page.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final panel = page[index];

                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    //alignment: Alignment.center,
                    children: [
                      Positioned.fill(child: panel['widget']),
                      Container(
                        height: 140,
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3ECE4),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Persona",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              "Let's get to know you better!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (dotIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: page[_currentPage]['color'][dotIndex],
                ),
              );
            }),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
