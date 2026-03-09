import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../auth_screen/otp_login_screen.dart';

// import '../../auth_screen/otp_login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/customer side/images/onboardings/onboarding.png',
      'title': 'Viaje com facilidade',
      'subtitle': 'Táxi rápido e entregas seguras\nna sua cidade',
    },
    {
      'image': 'assets/customer side/images/onboardings/onboarding.png',
      'title': 'Chegue com segurança',
      'subtitle': 'Motoristas verificados e rotas\notimizadas para você',
    },
    {
      'image': 'assets/customer side/images/onboardings/onboarding.png',
      'title': 'Economize seu tempo',
      'subtitle': 'Solicite seu transporte em\npoucos segundos',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OtpLoginScreen(),
        ),
      );
    }
  }

  void _onSkipPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    final Size size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Skip button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05, vertical: h * 0.01),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _onSkipPressed,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[600],
                    textStyle: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Pular'),
                ),
              ),
            ),

            // PageView for images
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(w * 0.04),
                      child: Image.asset(
                        _pages[index]['image']!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: h * 0.04,
                bottom: h * 0.04,
                left: w * 0.06,
                right: w * 0.06,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _pages[_currentPage]['title']!,
                      key: ValueKey(_currentPage),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.065,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF15305B),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.015),

                  // Subtitle
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _pages[_currentPage]['subtitle']!,
                      key: ValueKey('sub_$_currentPage'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.042,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),

                  // Progress Indicator (Dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final bool isActive = index == _currentPage;
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: w * 0.0075),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isActive ? w * 0.06 : w * 0.015,
                          height: w * 0.015,
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF2D66C1)
                                : const Color(0xFFB5C8E8),
                            borderRadius:
                            BorderRadius.circular(w * 0.01),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: h * 0.05),

                  // Gradient Next / Get Started Button
                  Container(
                    width: double.infinity,
                    height: h * 0.075,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2D66C1), Color(0xFF15305B)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(w * 0.025),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2D66C1).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(w * 0.025),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Começar'
                            : 'Próximo',
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}