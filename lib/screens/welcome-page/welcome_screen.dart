import 'dart:async';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  // Replace Lottie URLs with image asset paths
  final List<String> imageAssets = [
    'assets/images/onboarding_1.png',
    'assets/images/onboarding_2.png',
    'assets/images/onboarding_3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_controller.hasClients) {
        if (_currentPage < imageAssets.length - 1) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          _controller.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DFDB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/goparent_black_icon.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'GoParent',
                    style: TextStyle(
                      fontFamily: 'CodeNewRoman',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                    ),
                  ),
                ],
              ),
            ),

            // Image Carousel
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _resetTimer();
                  });
                },
                itemCount: imageAssets.length,
                itemBuilder: (context, index) {
                  // Using a placeholder image for now
                  return Image.asset(
                    imageAssets[index],
                    fit: BoxFit.contain,
                  );
                  // If you want to use placeholders during development:
                  // return Image.network(
                  //   'https://via.placeholder.com/350x250?text=Onboarding+${index + 1}',
                  //   fit: BoxFit.contain,
                  // );
                },
              ),
            ),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageAssets.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFF009688)
                        : Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signup_screen');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF009688),
                          minimumSize: const Size(double.infinity, 50),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('SIGN UP FOR FREE'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login_screen');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF009688),
                          backgroundColor: const Color(0xFFB2DFDB),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('SIGN IN'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
