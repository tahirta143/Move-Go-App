import 'package:flutter/material.dart';

import '../home_pro/home_pro.dart';


class ReportMisconductScreen extends StatefulWidget {
  const ReportMisconductScreen({super.key});

  @override
  State<ReportMisconductScreen> createState() => _ReportMisconductScreenState();
}

class _ReportMisconductScreenState extends State<ReportMisconductScreen> {
  // Radio selection — index of selected option
  int _selectedOption = 0;

  final List<String> _options = [
    'Pediu dinheiro extra',
    'Condução distraída',
    'Comportamento rude',
    'Condução perigosa',
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final sw = mq.size.width;
    final sh = mq.size.height;
    final hp = sw * 0.05; // horizontal padding

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      // ── Fixed bottom button ──────────────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(hp, sw * 0.03, hp, sh * 0.03),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          },
          child: Container(
            width: double.infinity,
            height: sh * 0.065,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2D66C1), Color(0xFF15305B)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              'Enviar Relatorio',
              style: TextStyle(
                fontSize: sw * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: hp,
                vertical: sh * 0.015,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: sw * 0.09,
                      height: sw * 0.09,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: const Color(0xFF1A1A2E),
                        size: sw * 0.06,
                      ),
                    ),
                  ),
                  SizedBox(width: sw * 0.04),
                  Text(
                    'Relatar Má Conduta',
                    style: TextStyle(
                      fontSize: sw * 0.052,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF15305B),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable body ────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: sh * 0.008),

                    // ── Driver info card ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(sw * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: sw * 0.065,
                            backgroundColor: const Color(0xFFD0D5E8),
                            child: Icon(
                              Icons.person,
                              size: sw * 0.07,
                              color: const Color(0xFF8A8A9A),
                            ),
                          ),
                          SizedBox(width: sw * 0.035),
                          // Driver details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'João Silva',
                                  style: TextStyle(
                                    fontSize: sw * 0.042,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1A2E),
                                  ),
                                ),
                                SizedBox(height: sh * 0.004),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: const Color(0xFFFFC107),
                                      size: sw * 0.04,
                                    ),
                                    SizedBox(width: sw * 0.01),
                                    Text(
                                      '4.8 (127)',
                                      style: TextStyle(
                                        fontSize: sw * 0.036,
                                        color: const Color(0xFF1A1A2E),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: sh * 0.006),
                                Text(
                                  'Toyota Corolla (LD-44-32-XX)',
                                  style: TextStyle(
                                    fontSize: sw * 0.037,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1A1A2E),
                                  ),
                                ),
                                SizedBox(height: sh * 0.003),
                                Text(
                                  'Hoje, 14:30 . Finalizada',
                                  style: TextStyle(
                                    fontSize: sw * 0.034,
                                    color: const Color(0xFF8A8A9A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: sh * 0.022),

                    // ── Section label ──────────────────────────────────────
                    Text(
                      'O Que Aconteceu?',
                      style: TextStyle(
                        fontSize: sw * 0.037,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8A8A9A),
                      ),
                    ),

                    SizedBox(height: sh * 0.01),

                    // ── Radio option list ──────────────────────────────────
                    ...List.generate(_options.length, (i) {
                      final bool isSelected = _selectedOption == i;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _selectedOption = i),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: sw * 0.045,
                                vertical: sh * 0.018,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _options[i],
                                    style: TextStyle(
                                      fontSize: sw * 0.038,
                                      color: const Color(0xFF1A1A2E),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  // Radio indicator
                                  Container(
                                    width: sw * 0.055,
                                    height: sw * 0.055,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? const Color(0xFF2D66C1)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF2D66C1)
                                            : const Color(0xFFCCCDD8),
                                        width: isSelected ? 0 : 1.5,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                      size: sw * 0.025,
                                    )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: sh * 0.008),
                        ],
                      );
                    }),

                    SizedBox(height: sh * 0.014),

                    // ── Evidências label ───────────────────────────────────
                    Text(
                      'Anexar Evidencias (Opcional)',
                      style: TextStyle(
                        fontSize: sw * 0.037,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8A8A9A),
                      ),
                    ),

                    SizedBox(height: sh * 0.012),

                    // ── Nota de Voz + Captura de Tela ──────────────────────
                    Row(
                      children: [
                        // Nota de Voz
                        Expanded(
                          child: Container(
                            height: sh * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mic_outlined,
                                  color: const Color(0xFF2D66C1),
                                  size: sw * 0.07,
                                ),
                                SizedBox(height: sh * 0.008),
                                Text(
                                  'Nota de Voz',
                                  style: TextStyle(
                                    fontSize: sw * 0.036,
                                    color: const Color(0xFF1A1A2E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: sw * 0.04),
                        // Captura de Tela
                        Expanded(
                          child: Container(
                            height: sh * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.crop_free_rounded,
                                  color: const Color(0xFF2D66C1),
                                  size: sw * 0.07,
                                ),
                                SizedBox(height: sh * 0.008),
                                Text(
                                  'Captura de Tela',
                                  style: TextStyle(
                                    fontSize: sw * 0.036,
                                    color: const Color(0xFF1A1A2E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: sh * 0.022),

                    // ── Mais Detalhes ──────────────────────────────────────
                    Text(
                      'Mais Detalhes',
                      style: TextStyle(
                        fontSize: sw * 0.048,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D66C1),
                      ),
                    ),
                    SizedBox(height: sh * 0.006),
                    Text(
                      'Descreva o ocorrido com mais detalhes para nos ajudar na investigação',
                      style: TextStyle(
                        fontSize: sw * 0.036,
                        color: const Color(0xFF8A8A9A),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: sh * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}