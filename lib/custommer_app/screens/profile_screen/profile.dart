import 'package:flutter/material.dart';
import '../cancel_trip_screen/cancel_screen.dart';
import '../chat_screen/chat_screen.dart';
import '../country_slection/country_slection.dart';
import '../notification_screen/notification_screen.dart';
import '../terms_screen/terms_screen.dart';
import '../trip_history_screen/trip_history_screen.dart';
// import 'termos_screen.dart'; // 🔁 Replace with your actual import path

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: SafeArea(
        child: Column(
          children: [

            // ── Top bar ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.05,
                vertical: sh * 0.018,
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
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 6,
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
                    'Perfil',
                    style: TextStyle(
                      fontSize: sw * 0.052,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A5DC8),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable body ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                child: Column(
                  children: [

                    SizedBox(height: sh * 0.008),

                    // Avatar
                    CircleAvatar(
                      radius: sw * 0.115,
                      backgroundColor: const Color(0xFF444444),
                      backgroundImage: const AssetImage(
                        'assets/customer side/images/home_images/profile.png',
                        // 🔁 Replace with your actual asset path
                      ),
                    ),

                    SizedBox(height: sh * 0.016),

                    // Name
                    Text(
                      'António Manuel',
                      style: TextStyle(
                        fontSize: sw * 0.056,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: sh * 0.005),

                    // Phone
                    Text(
                      '+244 923 000 000',
                      style: TextStyle(
                        fontSize: sw * 0.038,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    SizedBox(height: sh * 0.007),

                    // Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded,
                            color: const Color(0xFFFFC107),
                            size: sw * 0.048),
                        SizedBox(width: sw * 0.010),
                        Text('4.8',
                            style: TextStyle(
                                fontSize: sw * 0.040,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)),
                        SizedBox(width: sw * 0.010),
                        Text('(127)',
                            style: TextStyle(
                                fontSize: sw * 0.037,
                                color: Colors.grey.shade500)),
                      ],
                    ),

                    SizedBox(height: sh * 0.028),

                    // ── Group 1 ──────────────────────────────────────
                    _menuCard(
                      sw: sw,
                      sh: sh,
                      context: context,
                      items: [
                        _Item(
                          icon: Icons.access_time_outlined,
                          label: 'Historico de viagens',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TripHistoryScreen(),
                            ),
                          ),
                        ),
                        _Item(
                          icon: Icons.account_balance_wallet_outlined,
                          label: 'Carteira',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CancelarViagemScreen(),
                            ),
                          ),
                        ),
                        _Item(
                          icon: Icons.translate,
                          label: 'Idioma',
                          subtitle: 'Português',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CountrySlection(),
                            ),
                          ),
                        ),
                        _Item(
                          icon: Icons.notifications_none_outlined,
                          label: 'Notificações',
                          isLast: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificacoesScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: sh * 0.018),

                    // ── Group 2 ──────────────────────────────────────
                    _menuCard(
                      sw: sw,
                      sh: sh,
                      context: context,
                      items: [
                        _Item(
                          icon: Icons.description_outlined,
                          label: 'Termos',
                          // ✅ Navigate to TermosScreen on tap
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TermosScreen(),
                            ),
                          ),
                        ),
                        _Item(
                          icon: Icons.chat_bubble_outline,
                          label: 'Chat support',
                          isLast: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: sh * 0.018),

                    // ── Logout ───────────────────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(sw * 0.04),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(sw * 0.04),
                        onTap: () {
                          // TODO: Handle logout
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.05,
                            vertical: sh * 0.020,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: sw * 0.088,
                                height: sw * 0.088,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFECEC),
                                  borderRadius:
                                  BorderRadius.circular(sw * 0.022),
                                ),
                                child: Icon(Icons.logout,
                                    size: sw * 0.046,
                                    color: const Color(0xFFE53935)),
                              ),
                              SizedBox(width: sw * 0.04),
                              Text(
                                'Sair',
                                style: TextStyle(
                                  fontSize: sw * 0.042,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFE53935),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: sh * 0.030),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required double sw,
    required double sh,
    required BuildContext context,
    required List<_Item> items,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw * 0.04),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              InkWell(
                onTap: item.onTap ?? () {},
                borderRadius: BorderRadius.only(
                  topLeft:
                  i == 0 ? Radius.circular(sw * 0.04) : Radius.zero,
                  topRight:
                  i == 0 ? Radius.circular(sw * 0.04) : Radius.zero,
                  bottomLeft: item.isLast
                      ? Radius.circular(sw * 0.04)
                      : Radius.zero,
                  bottomRight: item.isLast
                      ? Radius.circular(sw * 0.04)
                      : Radius.zero,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.05,
                    vertical: sh * 0.020,
                  ),
                  child: Row(
                    children: [
                      // Icon box
                      Container(
                        width: sw * 0.088,
                        height: sw * 0.088,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F3F5),
                          borderRadius:
                          BorderRadius.circular(sw * 0.022),
                        ),
                        child: Icon(item.icon,
                            size: sw * 0.046, color: Colors.black54),
                      ),
                      SizedBox(width: sw * 0.04),
                      // Label + optional subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: sw * 0.042,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            if (item.subtitle != null) ...[
                              SizedBox(height: sh * 0.003),
                              Text(
                                item.subtitle!,
                                style: TextStyle(
                                  fontSize: sw * 0.036,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1A5DC8),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          size: sw * 0.055,
                          color: Colors.grey.shade400),
                    ],
                  ),
                ),
              ),
              if (!item.isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: sw * 0.05 + sw * 0.088 + sw * 0.04,
                  endIndent: sw * 0.05,
                  color: const Color(0xFFEEEEEE),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _Item {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool isLast;
  final VoidCallback? onTap;

  const _Item({
    required this.icon,
    required this.label,
    this.subtitle,
    this.isLast = false,
    this.onTap,
  });
}