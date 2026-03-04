import 'package:flutter/material.dart';

class TermosScreen extends StatelessWidget {
  const TermosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double sw = mediaQuery.size.width;
    final double sh = mediaQuery.size.height;
    final double hp = sw * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: sh * 0.015),

            // ── App Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Back arrow left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: sw * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Title center
                  Text(
                    'Termos',
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

            // ── Content Card ──
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.055,
                    vertical: sh * 0.028,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Section 1: Permissões do App ──
                      Text(
                        'Permissões do App',
                        style: TextStyle(
                          fontSize: sw * 0.048,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF15305B),
                        ),
                      ),
                      SizedBox(height: sh * 0.010),
                      Text(
                        'Precisamos de algumas permissões para garantir a melhor experiência na sua viageme manter você em segurança.',
                        style: TextStyle(
                          fontSize: sw * 0.038,
                          color: const Color(0xFF555555),
                          height: 1.55,
                        ),
                      ),

                      SizedBox(height: sh * 0.022),

                      // ── Section 2: Localização ──
                      Text(
                        'Localização',
                        style: TextStyle(
                          fontSize: sw * 0.048,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF15305B),
                        ),
                      ),
                      SizedBox(height: sh * 0.010),
                      Text(
                        'Permite que os motoristas encontrem você e que você acompanhe o trajeto em tempo real.',
                        style: TextStyle(
                          fontSize: sw * 0.038,
                          color: const Color(0xFF555555),
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Bottom Button ──
            Padding(
              padding: EdgeInsets.fromLTRB(hp, sh * 0.02, hp, sh * 0.035),
              child: SizedBox(
                width: double.infinity,
                height: sh * 0.065,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2A5298), Color(0xFF15305B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(sw * 0.034),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle permission grant
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sw * 0.034),
                      ),
                    ),
                    child: Text(
                      'Permitir',
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
            ),
          ],
        ),
      ),
    );
  }
}