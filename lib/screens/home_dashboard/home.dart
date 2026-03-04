import 'package:flutter/material.dart';
import '../profile_screen/profile.dart';
import '../success_payment_screen/success_payment.dart';
import 'fare_estimation/fare_estimation.dart';
// import 'profile_screen.dart'; // adjust path as needed

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _scaffoldKey,

      // ── Hide AppBar on Profile tab ──────────────────────────────
      appBar: _selectedIndex == 3
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/customer side/images/home_images/profile.png'),
            radius: 20,
            onBackgroundImageError: (exception, stackTrace) {},
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BEM-VINDO',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Text(
                  'Olá, João ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Text('👋', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () =>
                _scaffoldKey.currentState?.openEndDrawer(),
          ),
          const SizedBox(width: 8),
        ],
      ),

      endDrawer: _buildDrawer(),

      // ── IndexedStack keeps all tabs alive ───────────────────────
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // ── Tab 0: Home ────────────────────────────────────────
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 12 : 16,
              ),
              child: Column(
                children: [
                  _buildWalletCard(context),
                  SizedBox(height: isMobile ? 20 : 24),
                  _buildSearchBar(context),
                  SizedBox(height: isMobile ? 20 : 24),
                  _buildMapSection(context),
                  SizedBox(height: isMobile ? 24 : 32),
                  _buildRecentTripsHeader(),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildRecentTrips(context),
                  SizedBox(height: isMobile ? 24 : 32),
                  _buildAeroportoSection(),
                ],
              ),
            ),
          ),

          // ── Tab 1: Viagens ─────────────────────────────────────
          const Center(
            child: Text(
              'Viagens',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // ── Tab 2: Encomendas ──────────────────────────────────
          const Center(
            child: Text(
              'Encomendas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // ── Tab 3: Perfil ──────────────────────────────────────
          const ProfileScreen(),
        ],
      ),

      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ── Wallet Card ───────────────────────────────────────────────────
  Widget _buildWalletCard(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E5BA8), Color(0xFF2E7AC4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo da Carteira',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '15.400,00 AOA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: isMobile ? 24 : 28,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Carregar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1E5BA8),
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12 : 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ────────────────────────────────────────────────────
  Widget _buildSearchBar(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Para onde vamos?',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: isMobile ? 13 : 14,
          ),
          border: InputBorder.none,
          icon: Icon(Icons.location_on_outlined, color: Colors.grey[400]),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // ── Map Section ───────────────────────────────────────────────────
  Widget _buildMapSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      height: isMobile ? 200 : 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue[100],
        image: const DecorationImage(
          image: AssetImage(
              'assets/customer side/images/home_images/map.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.blue, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'EM DIRECTO: LUANDA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
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

  // ── Recent Trips Header ───────────────────────────────────────────
  Widget _buildRecentTripsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Viagens Recentes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Ver tudo',
            style: TextStyle(
              color: Color(0xFF1E5BA8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ── Recent Trips ──────────────────────────────────────────────────
  Widget _buildRecentTrips(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FareEstimationScreen(),
                ),
              );
            },
            child: _buildTripCard(
              title: 'Pedir Táxi',
              subtitle: 'Viagens rápidas e seguras',
              icon: Icons.local_taxi,
              color: const Color(0xFF1E5BA8),
              imageAsset:
              'assets/customer side/images/home_images/car.png',
              width: isMobile ? 160 : 200,
              hasImage: true,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentSuccessScreen(),
                ),
              );
            },
            child: _buildTripCard(
              title: 'Enviar',
              subtitle: 'Encomendar Entrega porta-a-porta',
              icon: Icons.local_shipping,
              color: const Color(0xFF5B7A9C),
              imageAsset:
              'assets/customer side/images/home_images/delivery_boy.png',
              width: isMobile ? 160 : 200,
              hasImage: true,
            ),
          ),


        ],
      ),
    );
  }

  // ── Trip Card ─────────────────────────────────────────────────────
  Widget _buildTripCard({
    required String title,
    required String subtitle,
    required String imageAsset,
    required double width,
    required Color color,
    required IconData icon,
    required bool hasImage,
  }) {
    return Container(
      width: width,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imageAsset, fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x00000000),
                    Color(0xCC0A1A3A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.35, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFB0C4DE),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Aeroporto Section ─────────────────────────────────────────────
  Widget _buildAeroportoSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF5F5F5),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.schedule,
              color: Color(0xFF1E5BA8),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aeroporto de Luanda',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ontem, 14:20 · AOA 4.500',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Nav Bar ────────────────────────────────────────────────
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1E5BA8),
        unselectedItemColor: Colors.grey[400],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Viagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Encomendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  // ── Drawer ────────────────────────────────────────────────────────
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E5BA8), Color(0xFF2E7AC4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                      'assets/customer side/images/home_images/profile.png'),
                  radius: 30,
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
                const SizedBox(height: 12),
                const Text(
                  'João Silva',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '+244 923 456 789',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
            const Icon(Icons.account_circle, color: Color(0xFF1E5BA8)),
            title: const Text('Meu Perfil'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 3); // go to Profile tab
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Color(0xFF1E5BA8)),
            title: const Text('Minha Carteira'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF1E5BA8)),
            title: const Text('Histórico de Viagens'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications,
                color: Color(0xFF1E5BA8)),
            title: const Text('Notificações'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading:
            const Icon(Icons.settings, color: Color(0xFF1E5BA8)),
            title: const Text('Configurações'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Color(0xFF1E5BA8)),
            title: const Text('Ajuda e Suporte'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}