import 'package:flutter/material.dart';

class TripItem {
  final String amount;
  final String status;
  final String destination;
  final String dateTime;
  final String vehicle;
  final Color statusColor;

  const TripItem({
    required this.amount,
    required this.status,
    required this.destination,
    required this.dateTime,
    required this.vehicle,
    required this.statusColor,
  });
}

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  int _selectedTab = 0;

  final List<TripItem> trips = const [
    TripItem(
      amount: '4.500 Kz',
      status: 'CONCLUIDA',
      destination: 'Aeroporto 4 de\nFevereiro',
      dateTime: '12 Out, 14:30',
      vehicle: 'Toyota Corolla',
      statusColor: Color(0xFF4CAF50),
    ),
    TripItem(
      amount: '2.800 Kz',
      status: 'CONCLUIDA',
      destination: 'Marginal de\nLuanda',
      dateTime: '12 Out, 14:30',
      vehicle: 'Toyota Corolla',
      statusColor: Color(0xFF4CAF50),
    ),
    TripItem(
      amount: '0 Kz',
      status: 'CONCLUIDA',
      destination: 'Talatona\nShopping',
      dateTime: '12 Out, 14:30',
      vehicle: 'Toyota Corolla',
      statusColor: Color(0xFFFF3B30),
    ),
    TripItem(
      amount: '0 Kz',
      status: 'CONCLUIDA',
      destination: 'Talatona\nShopping',
      dateTime: '12 Out, 14:30',
      vehicle: 'Toyota Corolla',
      statusColor: Color(0xFFFF3B30),
    ),
    TripItem(
      amount: '4.500 Kz',
      status: 'CONCLUIDA',
      destination: 'Kilamba\nCentral',
      dateTime: '12 Out, 14:30',
      vehicle: 'Toyota Corolla',
      statusColor: Color(0xFF4CAF50),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final double horizontalPadding = screenWidth * 0.045;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.015),

            // ── App Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: screenWidth * 0.05,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    'Histórico de Viagens',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.025),

            // ── Tab Selector ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTab('Viagens', 0, screenWidth),
                    SizedBox(width: screenWidth * 0.01),
                    _buildTab('Encomendas', 1, screenWidth),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // ── Trip List ──
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: screenHeight * 0.005,
                ),
                itemCount: trips.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: screenHeight * 0.012),
                itemBuilder: (context, index) {
                  return _buildTripCard(
                      trips[index], screenWidth, screenHeight);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index, double screenWidth) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.055,
          vertical: screenWidth * 0.022,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A3A6B) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.038,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF888888),
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(
      TripItem trip, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Left: Trip Info ──
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount + Status
                  Row(
                    children: [
                      Text(
                        trip.amount,
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A3A6B),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.025),
                      Text(
                        trip.status,
                        style: TextStyle(
                          fontSize: screenWidth * 0.032,
                          fontWeight: FontWeight.bold,
                          color: trip.statusColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  // Destination
                  Text(
                    trip.destination,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  // Date · Vehicle
                  Row(
                    children: [
                      Text(
                        trip.dateTime,
                        style: TextStyle(
                          fontSize: screenWidth * 0.032,
                          color: const Color(0xFF888888),
                        ),
                      ),
                      Text(
                        ' . ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.032,
                          color: const Color(0xFF888888),
                        ),
                      ),
                      Text(
                        trip.vehicle,
                        style: TextStyle(
                          fontSize: screenWidth * 0.032,
                          color: const Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Right: Map Image (Local Asset) ──
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: SizedBox(
              width: screenWidth * 0.28,
              height: screenHeight * 0.115,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 🗺️ Local asset map image
                  // Replace 'assets/images/rincon_del_bosque.png'
                  // with your actual asset path
                  Image.asset(
                    'assets/customer side/images/history_map.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if image not found
                      return Container(
                        color: const Color(0xFFC8E6C9),
                        child: Center(
                          child: Icon(
                            Icons.map_outlined,
                            color: const Color(0xFF5A7A5A),
                            size: screenWidth * 0.08,
                          ),
                        ),
                      );
                    },
                  ),

                  // Overlay: "Pdte. Masaryk" label at top
                  Positioned(
                    top: screenHeight * 0.008,
                    left: 0,
                    right: screenWidth * 0.055,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.015,
                          vertical: screenHeight * 0.002,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'Pdte. Masaryk',
                          style: TextStyle(
                            fontSize: screenWidth * 0.022,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Overlay: Blue number badge top-right
                  Positioned(
                    top: screenHeight * 0.006,
                    right: screenWidth * 0.02,
                    child: Container(
                      width: screenWidth * 0.045,
                      height: screenWidth * 0.045,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A6FBB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.028,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}