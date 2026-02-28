import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../auth_screen/otp_login_screen.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    // Restore the status bar (battery, wifi, time) with dark icons.
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
            // Top Bar: Pular (Skip) button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle skip action
                  },
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

            // Main Image
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(w * 0.04), // Rounded corners
                  child: Image.asset(
                    'assets/customer side/images/onboardings/onboarding.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
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
                  Text(
                    'Viaje com facilidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.065,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF15305B), // Dark blue
                    ),
                  ),
                  SizedBox(height: h * 0.015),

                  // Subtitle
                  Text(
                    'Táxi rápido e entregas seguras\nna sua cidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.042,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: h * 0.04),

                  // Progress Indicator (Dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Active indicator
                      Container(
                        width: w * 0.06,
                        height: w * 0.015,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D66C1),
                          borderRadius: BorderRadius.circular(w * 0.01),
                        ),
                      ),
                      SizedBox(width: w * 0.015),
                      // Inactive dot 1
                      Container(
                        width: w * 0.015,
                        height: w * 0.015,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB5C8E8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: w * 0.015),
                      // Inactive dot 2
                      Container(
                        width: w * 0.015,
                        height: w * 0.015,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB5C8E8),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.05),

                  // Gradient Next Button
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
                      onPressed: () {
                        // Handle Next action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtpLoginScreen()
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.025),
                        ),
                      ),
                      child: Text(
                        'Próximo',
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
