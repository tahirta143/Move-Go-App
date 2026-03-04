import 'package:flutter/material.dart';

import '../trip_history_screen/trip_history_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final double horizontalPadding = screenWidth * 0.06;
    final double iconOuterSize = screenWidth * 0.38;
    final double iconInnerSize = screenWidth * 0.22;
    final double checkIconSize = screenWidth * 0.12;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Centered Content ──
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Checkmark Icon with glowing rings ──
                    Center(
                      child: SizedBox(
                        width: iconOuterSize,
                        height: iconOuterSize,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outermost light green circle
                            Container(
                              width: iconOuterSize,
                              height: iconOuterSize,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD6F5D6),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Middle light green circle
                            Container(
                              width: iconOuterSize * 0.75,
                              height: iconOuterSize * 0.75,
                              decoration: const BoxDecoration(
                                color: Color(0xFFB2EBB2),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Inner solid green circle with checkmark
                            Container(
                              width: iconInnerSize,
                              height: iconInnerSize,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3DB84B),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: checkIconSize,
                                weight: 700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // ── Title ──
                    Text(
                      'Pagamento Confirmado!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -0.3,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.012),

                    // ── Subtitle ──
                    Text(
                      'O teu motorista esta a caminho do local\nde recolha.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        color: const Color(0xFF6B6B6B),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.035),

                    // ── Driver Info Card ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEEEEEE),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Driver avatar + name + rating row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ── Local Asset CircleAvatar ──
                              CircleAvatar(
                                radius: screenWidth * 0.065,
                                backgroundColor: const Color(0xFFBDBDBD),
                                backgroundImage: const AssetImage(
                                  'assets/customer side/images/home_images/profile.png',
                                  // 🔁 Replace with your actual asset path
                                  // e.g. 'assets/images/antonio.jpg'
                                ),
                              ),

                              SizedBox(width: screenWidth * 0.03),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Driver Name
                                  Text(
                                    'António Manuel',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.042,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.004),
                                  // Rating row
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: const Color(0xFFFFC107),
                                        size: screenWidth * 0.042,
                                      ),
                                      SizedBox(width: screenWidth * 0.01),
                                      Text(
                                        '4.8 (127)',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.036,
                                          color: const Color(0xFF555555),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.012),

                          // Car info
                          Text(
                            'Toyota Corolla (LD-44-32-XX)',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Bottom Button (fixed at bottom) ──
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TripHistoryScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A3A6B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Voltar Ao Inicio',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}