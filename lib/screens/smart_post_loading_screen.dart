import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/progress_step.dart';
import '../widgets/custom_header.dart';
import '../widgets/sub_navigation_row.dart';
import '../main.dart';

class SmartPostLoadingScreen extends StatefulWidget {
  const SmartPostLoadingScreen({super.key});

  @override
  State<SmartPostLoadingScreen> createState() => _SmartPostLoadingScreenState();
}

class _SmartPostLoadingScreenState extends State<SmartPostLoadingScreen> {
  int currentStep = 0;
  Timer? _timer;

  final List<String> _steps = [
    'Preparing popular content for you',
    'Crafting a caption to boost engagement',
    'Adding your personal referral link and code',
    'Finding trending songs on other social media',
  ];

  @override
  void initState() {
    super.initState();
    _startLoadingSequence();
  }

  void _startLoadingSequence() {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      if (currentStep < _steps.length) {
        setState(() {
          currentStep++;
        });
      } else {
        timer.cancel();
        // Wait enough time for the user to read the completion message before navigating
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
              ),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(),
            const SubNavigationRow(),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 52), // 151 (headers) + 52 = 203px from top
                    width: 274,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Center(
                          child: Text(
                            'Building personalised smart post for you',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32), // gap: 32px
                        
                        // Steps
                        ...List.generate(_steps.length, (index) {
                          return ProgressStep(
                            title: _steps[index],
                            loading: currentStep == index,
                            completed: currentStep > index,
                          );
                        }),
                        
                        // Completion Message
                        if (currentStep >= _steps.length)
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Center(
                              child: Text(
                                'All set! get ready to share',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
