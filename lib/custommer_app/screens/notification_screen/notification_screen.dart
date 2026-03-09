import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String body;
  final String time;
  final bool isRead;

  const NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
  });
}

class NotificacoesScreen extends StatelessWidget {
  const NotificacoesScreen({super.key});

  static const List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Sua viagem começou',
      body: 'O motorista já iniciou o trajeto. Relaxe e aproveite sua viagem.',
      time: 'Há 15 min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Nova promocao disponível',
      body: 'Ganhe 20% de desconto na sua próxima corrida usando o código EK20.',
      time: 'Há 15 min',
      isRead: true,
    ),
    NotificationItem(
      title: 'Perfil verificado',
      body: 'Sua conta foi validada com sucesso. Obrigado por confiar na EK.',
      time: 'Ontem',
      isRead: true,
    ),
    NotificationItem(
      title: 'Recibo de Viagem',
      body: 'O recibo da sua corrida de ontem já está disponível para consulta.',
      time: 'Ontem',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;
    final double hp = sw * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: sh * 0.015),

            // ── App Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: sw * 0.05,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: sw * 0.03),
                  Text(
                    'Centro de Notificações',
                    style: TextStyle(
                      fontSize: sw * 0.052,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: sh * 0.025),

            // ── Notification List ──
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: List.generate(_notifications.length, (index) {
                      final item = _notifications[index];
                      final isLast = index == _notifications.length - 1;
                      return _buildNotificationTile(
                        item: item,
                        sw: sw,
                        sh: sh,
                        isLast: isLast,
                      );
                    }),
                  ),
                ),
              ),
            ),

            SizedBox(height: sh * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required NotificationItem item,
    required double sw,
    required double sh,
    required bool isLast,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.045,
            vertical: sh * 0.018,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Bell Icon Box ──
              Container(
                width: sw * 0.11,
                height: sw * 0.11,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F5),
                  borderRadius: BorderRadius.circular(sw * 0.03),
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  size: sw * 0.055,
                  color: Colors.black54,
                ),
              ),

              SizedBox(width: sw * 0.035),

              // ── Text Content ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: sw * 0.040,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: sh * 0.005),

                    // Body
                    Text(
                      item.body,
                      style: TextStyle(
                        fontSize: sw * 0.034,
                        color: const Color(0xFF666666),
                        height: 1.45,
                      ),
                    ),
                    SizedBox(height: sh * 0.007),

                    // Time
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: sw * 0.032,
                        color: const Color(0xFF999999),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Divider between items (not after last)
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            indent: sw * 0.045,
            endIndent: sw * 0.045,
            color: const Color(0xFFEEEEEE),
          ),
      ],
    );
  }
}