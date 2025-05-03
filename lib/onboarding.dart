import 'package:flutter/material.dart';
import 'package:wanderin/authentication.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/onboard_slide1.png',
      'header': 'Welcome to\nWanderin!',
      'desc': 'Get ready to explore exciting new\ndestinations.'
    },
    {
      'image': 'assets/onboard_slide2.png',
      'header': 'Plan. Discover.\nTravel.',
      'desc': 'Find the best places and\nexperiences, tailored just for you.'
    },
    {
      'image': 'assets/onboard_slide3.png',
      'header': 'Let the journey\nbegin!',
      'desc': 'Your next adventure is only a tap\naway.'
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Authentication()));
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
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    final item = onboardingData[index];
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(item['image']!, height: 270),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  Text(item['header']!,
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.left),
                                  const SizedBox(height: 15),
                                  Text(item['desc']!,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      textAlign: TextAlign.left)
                                ],
                              )
                            ]));
                  }))
          // Row(
          //   children: [
          //     List.generate(onboardingData.length, (index) )
          //   ],
          // )
        ],
      ),
    );
  }
}
