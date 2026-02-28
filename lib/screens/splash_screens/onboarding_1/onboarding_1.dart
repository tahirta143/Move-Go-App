import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_go/screens/splash_screens/splash/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move-GO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Media Query
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── MAP BACKGROUND ──────────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/customer side/images/maps.png',
              fit: BoxFit.cover,
            ),
          ),

          // ── RED CENTER MARKER ───────────────────────────────────────
          Center(
            child: Image.asset(
              'assets/customer side/images/red.png',
              width: screenWidth * 0.10,
            ),
          ),

          // ── DARK OVERLAY ────────────────────────────────────────────
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),

          // ── MAIN CONTENT ────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Spacer to push logo to center
                const Spacer(),

                // ── LOGO SECTION ──────────────────────────────────────
                _LogoSection(screenWidth: screenWidth, screenHeight: screenHeight),

                const Spacer(),

                // ── BOTTOM BUTTONS SECTION ───────────────────────────
                _BottomButtonsSection(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  bottomPadding: bottomPadding,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LOGO SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _LogoSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const _LogoSection({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double logoSize = screenWidth * 0.32;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── CAR LOGO IMAGE ──
        SizedBox(
          width: logoSize,
          height: logoSize,
          child: Image.asset(
            'assets/customer side/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(height: screenHeight * 0.010),

        // ── APP NAME ──
        // Text(
        //   'Move-GO',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: screenWidth * 0.090,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: 1.0,
        //     shadows: const [
        //       Shadow(
        //         color: Colors.black45,
        //         blurRadius: 8,
        //         offset: Offset(0, 2),
        //       ),
        //     ],
        //   ),
        // ),

        SizedBox(height: screenHeight * 0.010),

        // ── TAGLINE with location pin ──
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: const Color(0xFFCC0000),
              size: screenWidth * 0.055,
            ),
            SizedBox(width: screenWidth * 0.010),
            Text(
              'Movendo você com confiança',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.042,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
                shadows: const [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
class _BottomButtonsSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final double bottomPadding;

  const _BottomButtonsSection({
    required this.screenWidth,
    required this.screenHeight,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = screenWidth * 0.06;
    final double buttonHeight = screenHeight * 0.072;
    final double fontSize = screenWidth * 0.042;

    return Container(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: bottomPadding + screenHeight * 0.025,
        top: screenHeight * 0.015,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── GET STARTED BUTTON (White with blue text) ──
          SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to registration / onboarding flow
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A6FD4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.012),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A6FD4),
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.018),

          // ── LOG IN BUTTON (Transparent with white text & border) ──
          SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: OutlinedButton(
              onPressed: () {
                // Navigate to login screen
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.012),
                ),
              ),
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}