import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:move_go/screens/splash_screens/onboarding_screens/onboarding_screens.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SPLASH SCREEN
//  • Blue gradient background (exact match to design)
//  • YOUR OWN logo image:  assets/images/logo.png
//  • Animated: logo scale + fade → text fade → progress bar fill
//  • Bottom: "ANGOLA . PALOP" with letter spacing
// ─────────────────────────────────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _textFade;
  late Animation<double> _progressAnim;
  late Animation<double> _bottomFade;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.40, curve: Curves.easeIn),
    ));

    _logoScale = Tween<double>(begin: 0.65, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutBack),
    ));

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.30, 0.60, curve: Curves.easeIn),
    ));

    _progressAnim =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.50, 1.0, curve: Curves.easeInOut),
        ));

    _bottomFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 0.70, curve: Curves.easeIn),
    ));

    _controller.forward().then((_) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen2()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A3A6B), // dark navy top
              Color(0xFF1F4E8C), // mid blue
              Color(0xFF1A5296), // slightly lighter mid
              Color(0xFF1A4A8A), // bottom blue
            ],
            stops: [0.0, 0.35, 0.65, 1.0],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              children: [
                // ── CENTER: Logo + App name + Tagline ──────────────────────
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── YOUR OWN LOGO ──────────────────────────────────
                      // Place your logo at: assets/images/logo.png
                      FadeTransition(
                        opacity: _logoFade,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: SizedBox(
                            width: w * 0.34,
                            height: w * 0.34,
                            child: Image.asset(
                              'assets/customer side/images/logo.png',
                              fit: BoxFit.contain,
                              // Fallback: painted logo if asset missing
                              errorBuilder: (_, __, ___) => CustomPaint(
                                painter: _SplashLogoPainter(),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.022),

                      // App name
                      // FadeTransition(
                      //   opacity: _textFade,
                      //   child: Text(
                      //     'Move-GO',
                      //     style: TextStyle(
                      //       fontSize: w * 0.082,
                      //       fontWeight: FontWeight.w800,
                      //       color: Colors.white,
                      //       letterSpacing: 0.5,
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: h * 0.012),

                      // Tagline
                      FadeTransition(
                        opacity: _textFade,
                        child: Text(
                          'Movendo você com confiança',
                          style: TextStyle(
                            fontSize: w * 0.042,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── BOTTOM: Progress bar + ANGOLA . PALOP ──────────────────
                Positioned(
                  bottom: h * 0.08,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _bottomFade,
                    child: Column(
                      children: [
                        // Progress bar
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: w * 0.12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                // track
                                Container(
                                  height: h * 0.006,
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(0.25),
                                ),
                                // animated fill
                                Container(
                                  height: h * 0.006,
                                  width: (w * 0.76) * _progressAnim.value,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.022),

                        // ANGOLA . PALOP
                        Text(
                          'ANGOLA . PALOP',
                          style: TextStyle(
                            fontSize: w * 0.042,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  FALLBACK LOGO (used only if assets/images/logo.png not found)
// ═══════════════════════════════════════════════════════════════════════════
class _SplashLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final whitePaint = Paint()..color = Colors.white;

    // outer arc
    canvas.drawArc(
      Rect.fromLTWH(w * 0.04, h * 0.0, w * 0.92, h * 0.82),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.072
        ..strokeCap = StrokeCap.butt,
    );

    // left/right legs
    canvas.drawLine(Offset(w * 0.04, h * 0.41), Offset(w * 0.04, h * 0.58),
        Paint()..color = Colors.white..strokeWidth = w * 0.07..strokeCap = StrokeCap.square);
    canvas.drawLine(Offset(w * 0.96, h * 0.41), Offset(w * 0.96, h * 0.58),
        Paint()..color = Colors.white..strokeWidth = w * 0.07..strokeCap = StrokeCap.square);

    // car body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, h * 0.60), width: w * 0.68, height: h * 0.26),
        const Radius.circular(6),
      ),
      whitePaint,
    );

    // cabin
    canvas.drawPath(
      Path()
        ..moveTo(cx - w * 0.22, h * 0.47)
        ..lineTo(cx - w * 0.13, h * 0.32)
        ..lineTo(cx + w * 0.13, h * 0.32)
        ..lineTo(cx + w * 0.22, h * 0.47)
        ..close(),
      whitePaint,
    );

    // windshield
    canvas.drawPath(
      Path()
        ..moveTo(cx - w * 0.165, h * 0.465)
        ..lineTo(cx - w * 0.095, h * 0.335)
        ..lineTo(cx + w * 0.095, h * 0.335)
        ..lineTo(cx + w * 0.165, h * 0.465)
        ..close(),
      Paint()..color = const Color(0xFF1A3A6B),
    );

    // EK badge
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, h * 0.515), width: w * 0.22, height: h * 0.10),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xFF1A3A6B),
    );
    final tp = TextPainter(
      text: const TextSpan(
          text: 'EK',
          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, h * 0.515 - tp.height / 2));

    // wheels
    canvas.drawCircle(Offset(cx - w * 0.21, h * 0.73), w * 0.085, whitePaint);
    canvas.drawCircle(Offset(cx - w * 0.21, h * 0.73), w * 0.055,
        Paint()..color = const Color(0xFF1A3A6B));
    canvas.drawCircle(Offset(cx + w * 0.21, h * 0.73), w * 0.085, whitePaint);
    canvas.drawCircle(Offset(cx + w * 0.21, h * 0.73), w * 0.055,
        Paint()..color = const Color(0xFF1A3A6B));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}