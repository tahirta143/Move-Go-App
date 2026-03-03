import 'package:flutter/material.dart';

import '../rating_screen/rating_screen.dart';

class LiveRideTrackingScreen extends StatefulWidget {
  const LiveRideTrackingScreen({Key? key}) : super(key: key);

  @override
  State<LiveRideTrackingScreen> createState() => _LiveRideTrackingScreenState();
}

class _LiveRideTrackingScreenState extends State<LiveRideTrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _carAnimController;
  late Animation<double> _carAnimation;

  @override
  void initState() {
    super.initState();
    _carAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _carAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _carAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _carAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 900;
    final hPad = isMobile ? 16.0 : isTablet ? 32.0 : 64.0;

    // Map takes ~55% of screen height
    final mapHeight = size.height * 0.95;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── MAP AREA ──
          SizedBox(
            height: mapHeight,
            width: double.infinity,
            child: _buildMapArea(context, mapHeight, isMobile),
          ),

          // ── TOP BAR (back + status pill) ──
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: hPad,
            right: hPad,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 16, color: Colors.black87),
                  ),
                ),
                const Spacer(),
                // "A Caminho" status pill
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF27AE60),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'A Caminho',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 36),
              ],
            ),
          ),

          // ── ZOOM CONTROLS ──
          Positioned(
            right: hPad,
            top: mapHeight * 0.45,
            child: Column(
              children: [
                _buildZoomButton(Icons.add),
                const SizedBox(height: 2),
                _buildZoomButton(Icons.remove),
              ],
            ),
          ),

          // ── BOTTOM SHEET ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSheet(context, hPad, isMobile, isTablet),
          ),
        ],
      ),
    );
  }

  // ── Map using asset image + animated car + route overlay ──
  Widget _buildMapArea(BuildContext context, double mapHeight, bool isMobile) {
    return ClipRect(
      child: SizedBox(
        height: mapHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background map image ──
            Image.asset(
              'assets/customer side/images/live_maps.png',
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: mapHeight,
              errorBuilder: (context, error, stackTrace) {
                // Fallback: plain color if image not found
                return Container(
                  color: const Color(0xFFE8E0D8),
                  child: const Center(
                    child: Icon(Icons.map, size: 60, color: Colors.grey),
                  ),
                );
              },
            ),

            // ── Route line overlay drawn on top of map ──
            CustomPaint(
              painter: _RoutePainter(),
              child: const SizedBox.expand(),
            ),

            // ── Animated car icon moving along route ──
            AnimatedBuilder(
              animation: _carAnimation,
              builder: (context, child) {
                final size = MediaQuery.of(context).size;

                // Route waypoints (matching _RoutePainter path)
                final waypoints = [
                  Offset(size.width * 0.15, mapHeight * 0.78),
                  Offset(size.width * 0.15, mapHeight * 0.60),
                  Offset(size.width * 0.35, mapHeight * 0.60),
                  Offset(size.width * 0.35, mapHeight * 0.45),
                  Offset(size.width * 0.55, mapHeight * 0.45),
                  Offset(size.width * 0.55, mapHeight * 0.28),
                  Offset(size.width * 0.72, mapHeight * 0.28),
                ];

                final pos = _getPositionOnPath(waypoints, _carAnimation.value);

                return Stack(
                  children: [
                    Positioned(
                      left: pos.dx - 16,
                      top: pos.dy - 16,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.directions_car,
                          size: 18,
                          color: Color(0xFF1E5BA8),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Interpolates position along a polyline of [waypoints] at [t] ∈ [0,1]
  Offset _getPositionOnPath(List<Offset> waypoints, double t) {
    if (waypoints.isEmpty) return Offset.zero;
    if (t <= 0) return waypoints.first;
    if (t >= 1) return waypoints.last;

    // Calculate total path length
    double totalLength = 0;
    final segments = <double>[];
    for (int i = 0; i < waypoints.length - 1; i++) {
      final d = (waypoints[i + 1] - waypoints[i]).distance;
      segments.add(d);
      totalLength += d;
    }

    // Find position at t * totalLength
    double target = t * totalLength;
    for (int i = 0; i < segments.length; i++) {
      if (target <= segments[i]) {
        final segT = target / segments[i];
        return Offset.lerp(waypoints[i], waypoints[i + 1], segT)!;
      }
      target -= segments[i];
    }
    return waypoints.last;
  }

  Widget _buildZoomButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }

  Widget _buildBottomSheet(
      BuildContext context, double hPad, bool isMobile, bool isTablet) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        hPad,
        20,
        hPad,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Driver row ──
          Row(
            children: [
              CircleAvatar(
                radius: isMobile ? 22 : 26,
                backgroundColor: const Color(0xFFE0E0E0),
                backgroundImage: const AssetImage(
                  'assets/customer side/images/home_images/profile.png',
                ),
                onBackgroundImageError: (_, __) {},
                // child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'António Manuel',
                      style: TextStyle(
                        fontSize: isMobile ? 15 : 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Color(0xFFF4B400), size: 15),
                        const SizedBox(width: 4),
                        Text(
                          '4.8 (127)',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SOS + Chat + Call
              Row(
                children: [
                  _buildActionChip('SOS',
                      bgColor: const Color(0xFFFFF3F3),
                      textColor: Colors.red),
                  const SizedBox(width: 8),
                  _buildIconAction(Icons.chat_bubble_outline),
                  const SizedBox(width: 8),
                  _buildIconAction(Icons.phone_outlined),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Destination + Share ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Heading to Downtown Plaza',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Blue Tesla Diesel Taxi',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 13,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.share, size: 15, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Share Trip',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey[200], height: 1),
          const SizedBox(height: 16),

          // ── ETA row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '14:15',
                    style: TextStyle(
                      fontSize: isMobile ? 22 : 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'TEMPO ESTIMADO',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '12 min left',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E5BA8),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Distância: 1.2km',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.45,
              minHeight: 5,
              backgroundColor: const Color(0xFFE8EDF5),
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFF1E5BA8)),
            ),
          ),

          const SizedBox(height: 20),

          // ── Action buttons ──
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RateYourRideScreen()));},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5BA8),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 14 : 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Partilhar Viagem',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showCancelDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 14 : 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(String label,
      {required Color bgColor, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildIconAction(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.black87),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancelar Viagem',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content:
        const Text('Tem a certeza que deseja cancelar esta viagem?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Não',
                style: TextStyle(color: Color(0xFF1E5BA8))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Sim, Cancelar'),
          ),
        ],
      ),
    );
  }
}

// ── Route + dots drawn on top of the map image ──
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final routePaint = Paint()
      ..color = const Color(0xFF1E5BA8)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routeShadow = Paint()
      ..color = const Color(0xFF1E5BA8).withOpacity(0.25)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final routePath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.78)
      ..lineTo(size.width * 0.15, size.height * 0.60)
      ..lineTo(size.width * 0.35, size.height * 0.60)
      ..lineTo(size.width * 0.35, size.height * 0.45)
      ..lineTo(size.width * 0.55, size.height * 0.45)
      ..lineTo(size.width * 0.55, size.height * 0.28)
      ..lineTo(size.width * 0.72, size.height * 0.28);

    canvas.drawPath(routePath, routeShadow);
    canvas.drawPath(routePath, routePaint);

    // ── Origin dot (white ring + blue fill) ──
    _drawDot(canvas, Offset(size.width * 0.15, size.height * 0.78),
        const Color(0xFF1E5BA8));

    // ── Destination dot (white ring + blue fill) ──
    _drawDot(canvas, Offset(size.width * 0.72, size.height * 0.28),
        const Color(0xFF27AE60));
  }

  void _drawDot(Canvas canvas, Offset center, Color color) {
    canvas.drawCircle(center, 8,
        Paint()..color = color..style = PaintingStyle.fill);
    canvas.drawCircle(
        center,
        8,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}