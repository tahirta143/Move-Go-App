import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sos_emmergency_flow/sos_emmergency_flow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedRide = 'Conforto';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isMediumScreen = size.width >= 360 && size.width < 400;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF7DD3E8),
      drawer: _buildDrawer(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header Section with Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/customer side/images/home_blue.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(context, size, isSmallScreen),
                  const SizedBox(height: 50),
                  _buildLocationCard(size, isSmallScreen),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Ride Selection Section
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildRideHeader(isSmallScreen),
                    const SizedBox(height: 15),
                    Expanded(
                      child: _buildRideOptions(size, isSmallScreen),
                    ),
                    // Dinheiro Section (moved here)
                    const SizedBox(height: 12),
                    _buildDinheiroSection(isSmallScreen),
                    const SizedBox(height: 12),
                    // Bottom Confirm Button
                    _buildBottomSection(context, size, isSmallScreen),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader(BuildContext context, Size size, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          // Profile Section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 15,
                vertical: isSmallScreen ? 8 : 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  // Profile Image - Use from assets
                  CircleAvatar(
                    radius: isSmallScreen ? 18 : 20,
                    backgroundImage: const AssetImage('assets/customer side/images/home_images/profile.png'),
                    onBackgroundImageError: (_, __) {},
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'BEM-VINDO',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 9 : 10,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Olá, João',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Text(' 👋'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // MAVEN Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7DD3E8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'MAVEN',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 9 : 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 10),

          // SOS Button
          GestureDetector(
            onTap: () {
              // Navigate to SOS Emergency Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SOSEmergencyScreen(),
                ),
              );
            },
            child: Container(
              width: isSmallScreen ? 45 : 50,
              height: isSmallScreen ? 45 : 50,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 10),

          // Notification Button
          GestureDetector(
            onTap: () {
              // Handle notification action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              width: isSmallScreen ? 45 : 50,
              height: isSmallScreen ? 45 : 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.black87,
                      size: isSmallScreen ? 22 : 24,
                    ),
                  ),
                  // Notification Badge (optional - shows unread count)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 10),

          // Menu Button
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Container(
              width: isSmallScreen ? 45 : 50,
              height: isSmallScreen ? 45 : 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.menu,
                color: Colors.black87,
                size: isSmallScreen ? 22 : 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(Size size, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 15 : 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey.shade600,
                  size: isSmallScreen ? 20 : 22,
                ),
                SizedBox(width: isSmallScreen ? 8 : 10),
                Text(
                  'Sua localização',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 10 : 12),
            Row(
              children: [
                Icon(
                  Icons.my_location,
                  color: Colors.grey.shade600,
                  size: isSmallScreen ? 20 : 22,
                ),
                SizedBox(width: isSmallScreen ? 8 : 10),
                Expanded(
                  child: Text(
                    'Avenida Comandante Gika, Luanda',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Icon(
                  Icons.add_circle_outline,
                  color: const Color(0xFF7DD3E8),
                  size: isSmallScreen ? 22 : 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideHeader(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Escolha uma viagem',
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            '3 MIN DISPONÍVEIS',
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOptions(Size size, bool isSmallScreen) {
    final rides = [
      {
        'name': 'Economico',
        'time': '3 min',
        'type': 'Chegada economica',
        'price': '1.200 Kz',
        'badge': 'Melhor preço',
        'badgeColor': const Color(0xFF4CAF50),
        'passengers': 4,
        'image': 'assets/customer side/images/car2.png',
      },
      {
        'name': 'Conforto',
        'time': '5 min',
        'type': 'Carros espaçosos',
        'price': '1.850 Kz',
        'badge': 'Recomendado',
        'badgeColor': const Color(0xFF2196F3),
        'passengers': 4,
        'image': 'assets/customer side/images/car3.png',
      },
      {
        'name': 'Premium Luxe',
        'time': '3 min',
        'type': 'Motoristas',
        'subtype': 'Top rated',
        'price': '1.200 Kz',
        'badge': 'Melhor preço',
        'badgeColor': const Color(0xFF4CAF50),
        'passengers': 4,
        'image': 'assets/customer side/images/car4.png',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 24,
        vertical: 5,
      ),
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        final isSelected = selectedRide == ride['name'];

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedRide = ride['name'] as String;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(isSmallScreen ? 12 : 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF2F5597)
                    : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Car Image
                Container(
                  width: isSmallScreen ? 55 : 60,
                  height: isSmallScreen ? 55 : 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    ride['image'] as String,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.directions_car,
                        size: isSmallScreen ? 30 : 35,
                        color: Colors.grey.shade400,
                      );
                    },
                  ),
                ),
                SizedBox(width: isSmallScreen ? 12 : 15),
                // Ride Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ride['name'] as String,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 15 : 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.person,
                            size: isSmallScreen ? 13 : 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${ride['passengers']}',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${ride['time']} · ${ride['type']}',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 11 : 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (ride['subtype'] != null)
                        Text(
                          ride['subtype'] as String,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 11 : 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                // Price and Badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ride['price'] as String,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: (ride['badgeColor'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ride['badge'] as String,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 9 : 10,
                          fontWeight: FontWeight.w600,
                          color: ride['badgeColor'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // NEW: Dinheiro Section as separate container
  Widget _buildDinheiroSection(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 18,
              vertical: isSmallScreen ? 12 : 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/customer side/images/money.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.attach_money,
                            color: Color(0xFF4CAF50),
                            size: 20,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Dinheiro',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: isSmallScreen ? 18 : 20,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),

              ],
            ),
          ),
          SizedBox(width: 39,),
          Text(
            't 8.4 km . 18 min',
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, Size size, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2D66C1),
              Color(0xFF15305B),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2D66C1).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle confirm action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Confirmado: $selectedRide'),
                backgroundColor: const Color(0xFF2F5597),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 14 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Confirmar $selectedRide',
            style: TextStyle(
              fontSize: isSmallScreen ? 15 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Inicio',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.directions_car,
                label: 'Viagens',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.calendar_today,
                label: 'Encomendas',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Perfil',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2F5597) : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFF2F5597) : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF7DD3E8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: const AssetImage('assets/customer side/images/home_images/profile.png'),
                  onBackgroundImageError: (_, __) {},
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'João',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'joao@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('Viagens'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Encomendas'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ajuda'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}