import 'package:flutter/material.dart';

class DriverMatchingScreen extends StatefulWidget {
  const DriverMatchingScreen({super.key});

  @override
  State<DriverMatchingScreen> createState() => _DriverMatchingScreenState();
}

class _DriverMatchingScreenState extends State<DriverMatchingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _progressAnimation =
        Tween<double>(begin: 0.0, end: 0.72).animate(_progressController);
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          // ══════════════════════════════════════════════════════════
          // TOP SECTION — Map fills this entire area edge to edge
          // ══════════════════════════════════════════════════════════
          Expanded(
            child: Stack(
              children: [

                // ── 1. Map full width/height of this section ────────
                Positioned.fill(
                  child: Image.asset(
                    'assets/customer side/images/driver_map.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFB8D4E8),
                    ),
                  ),
                ),

                // ── 2. SafeArea UI overlaid on map ──────────────────
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [

                      // ── AppBar row ─────────────────────────────
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.05,
                          vertical: sh * 0.016,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.maybePop(context),
                                child: Container(
                                  width: sw * 0.09,
                                  height: sw * 0.09,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.12),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: sw * 0.055,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Driver Matching',
                              style: TextStyle(
                                fontSize: sw * 0.052,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF15305B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Status Card ────────────────────────────
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.05),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.045,
                            vertical: sh * 0.016,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(sw * 0.04),
                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.black.withOpacity(0.12),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Procurando motorista proximo',
                                style: TextStyle(
                                  fontSize: sw * 0.038,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF2D66C1),
                                ),
                              ),
                              SizedBox(height: sh * 0.004),
                              Text(
                                'Isto pode levar alguns segundos',
                                style: TextStyle(
                                  fontSize: sw * 0.033,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(height: sh * 0.014),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'EK PULSE',
                                    style: TextStyle(
                                      fontSize: sw * 0.034,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'Buscando ralo 2km',
                                    style: TextStyle(
                                      fontSize: sw * 0.032,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: sh * 0.008),
                              AnimatedBuilder(
                                animation: _progressAnimation,
                                builder: (context, _) {
                                  return Container(
                                    width: double.infinity,
                                    height: sh * 0.010,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius:
                                      BorderRadius.circular(100),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor:
                                      _progressAnimation.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient:
                                          const LinearGradient(
                                            colors: [
                                              Color(0xFF2D66C1),
                                              Color(0xFF15305B),
                                            ],
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              100),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Driver pin centered in remaining map space
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(sw * 0.010),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2D66C1),
                                      Color(0xFF15305B),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2D66C1)
                                          .withOpacity(0.5),
                                      blurRadius: 18,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: sw * 0.068,
                                  backgroundColor: Colors.white,
                                  backgroundImage: const AssetImage(
                                    'assets/customer side/images/home_images/profile.png',
                                  ),
                                ),
                              ),
                              SizedBox(height: sh * 0.012),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.05,
                                  vertical: sh * 0.008,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(sw * 0.07),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.15),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'António Manuel',
                                  style: TextStyle(
                                    fontSize: sw * 0.037,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ══════════════════════════════════════════════════════════
          // BOTTOM SECTION — White background, trip card + button
          // ══════════════════════════════════════════════════════════
          // ══════════════════════════════════════════════════════════
// BOTTOM SECTION — rounded top-left & top-right corners
// ══════════════════════════════════════════════════════════
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sw * 0.05),   // ← rounded top-left
                topRight: Radius.circular(sw * 0.05),  // ← rounded top-right
                // bottom stays flat (0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 16,
                  offset: const Offset(0, -4),  // shadow goes upward onto map
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(
              sw * 0.05,
              sh * 0.018,
              sw * 0.05,
              sh * 0.025,
            ),
            child: Column(
              children: [

                // ── Trip Info Card ───────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.04,
                    vertical: sh * 0.016,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/customer side/images/car2.png',
                        width: sw * 0.18,
                        height: sw * 0.12,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.directions_car,
                          size: sw * 0.12,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(width: sw * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Viagem Premium',
                              style: TextStyle(
                                fontSize: sw * 0.042,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: sh * 0.005),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: sw * 0.034,
                                  color: Colors.grey.shade600,
                                ),
                                children: const [
                                  TextSpan(text: 'Pagamento: '),
                                  TextSpan(
                                    text: 'Dinheiro\n(Cash)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '1.200 Kz',
                            style: TextStyle(
                              fontSize: sw * 0.046,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: sh * 0.003),
                          Text(
                            'Estimado',
                            style: TextStyle(
                              fontSize: sw * 0.030,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sh * 0.016),

                // ── Cancel Button ────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: sh * 0.068,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2D66C1), Color(0xFF15305B)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(sw * 0.034),
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.maybePop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.034),
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: sw * 0.048,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ```
//
// **Exact layout structure:**
// ```
// Scaffold(backgroundColor: white)
// └── Column
// ├── Expanded  ← MAP AREA (edge to edge, no padding)
// │    └── Stack
// │         ├── Positioned.fill → map image (100% width & height)
// │         └── SafeArea(bottom: false)
// │              └── Column
// │                   ├── AppBar row  (floating on map)
// │                   ├── Status card (floating on map)
// │                   └── Expanded → driver pin (centered on map)
// │
// └── Container(color: white)  ← WHITE BOTTOM (trip card + button)
// ├── Trip info card
// └── Cancel button