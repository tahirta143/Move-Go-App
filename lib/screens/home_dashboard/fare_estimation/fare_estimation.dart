import 'package:flutter/material.dart';

import 'live_tracking_ride/live_tracking.dart';

class FareEstimationScreen extends StatefulWidget {
  const FareEstimationScreen({Key? key}) : super(key: key);

  @override
  State<FareEstimationScreen> createState() => _FareEstimationScreenState();
}

class _FareEstimationScreenState extends State<FareEstimationScreen> {
  int _selectedRide = 1;

  final List<Map<String, dynamic>> _rides = [
    {
      'name': 'Economico',
      'seats': 4,
      'eta': '3 min',
      'desc': 'Chegada economica',
      'price': '1.200 Kz',
      'badge': 'Melhor preço',
      'badgeColor': Color(0xFF1E5BA8),
      'image': 'assets/customer side/images/car2.png',
    },
    {
      'name': 'Conforto',
      'seats': 4,
      'eta': '5 min',
      'desc': 'Carros espaçosos',
      'price': '1.850 Kz',
      'badge': 'Recomendado',
      'badgeColor': Color(0xFF27AE60),
      'image': 'assets/customer side/images/car3.png',
    },
    {
      'name': 'Premium Luxe',
      'seats': 4,
      'eta': '3 min',
      'desc': 'Motoristas Top rated',
      'price': '1.200 Kz',
      'badge': 'Melhor preço',
      'badgeColor': Color(0xFF1E5BA8),
      'image': 'assets/customer side/images/car4.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 900;
    final hPad = isMobile ? 16.0 : isTablet ? 32.0 : 64.0;

    return Scaffold(
      backgroundColor: const Color(0xFF5BB8D4),
      body: Column(
        children: [
          _buildHeader(context, hPad),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: hPad, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Escolha uma viagem',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F4FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  '3 MIN DISPONÍVEIS',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF1E5BA8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Ride options
                          ...List.generate(_rides.length,
                                  (i) => _buildRideOption(i, isMobile)),

                          const SizedBox(height: 16),

                          // Payment + distance row
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                     Image.asset("assets/customer side/images/money.png"),
                                      const SizedBox(width: 6),
                                      const Text('Dinheiro',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.keyboard_arrow_down,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                't 8.4 km · 18 min',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Confirm button
                  Padding(
                    padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LiveRideTrackingScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E5BA8),
                              foregroundColor: Colors.white,
                              padding:
                              const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Confirmar ${_rides[_selectedRide]['name']}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'SUA SEGURANÇA É NOSSA PRIORIDADE, VIAGENS MONITORADAS POR GPS EM TEMPO REAL.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              letterSpacing: 0.3),
                        ),
                        SizedBox(
                            height:
                            MediaQuery.of(context).padding.bottom + 8),
                      ],
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

  Widget _buildHeader(BuildContext context, double hPad) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        hPad,
        MediaQuery.of(context).padding.top + 12,
        hPad,
        50,
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 16, color: Colors.black87),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Fare Estimation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ],
            ),
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.my_location,
                        color: Color(0xFF1E5BA8), size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('Sua localização',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[600])),
                    ),
                  ],
                ),
                Divider(height: 16, color: Colors.grey[200]),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Color(0xFF5BB8D4), size: 18),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Avenida Comandante Gika, Luanda',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Icon(Icons.add,
                        color: Color(0xFF1E5BA8), size: 20),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Norwegian Sea',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5), fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOption(int index, bool isMobile) {
    final ride = _rides[index];
    final isSelected = _selectedRide == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedRide = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF0F4FF)
              : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1E5BA8)
                : Colors.grey.withOpacity(0.15),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: isMobile ? 60 : 72,
              height: isMobile ? 44 : 52,
              child: Image.asset(
                ride['image'],
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.directions_car,
                  color: const Color(0xFF1E5BA8),
                  size: isMobile ? 36 : 44,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(ride['name'],
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      const SizedBox(width: 6),
                      Icon(Icons.person,
                          size: 13, color: Colors.grey[500]),
                      Text(' ${ride['seats']}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${ride['eta']} · ${ride['desc']}',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[500])),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(ride['price'],
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                Text(ride['badge'],
                    style: TextStyle(
                        fontSize: 11,
                        color: ride['badgeColor'],
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}