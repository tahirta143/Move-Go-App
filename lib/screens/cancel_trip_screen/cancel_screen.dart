import 'package:flutter/material.dart';

class CancelarViagemScreen extends StatefulWidget {
  const CancelarViagemScreen({super.key});

  @override
  State<CancelarViagemScreen> createState() => _CancelarViagemScreenState();
}

class _CancelarViagemScreenState extends State<CancelarViagemScreen> {
  int _selectedIndex = 0; // First option selected by default

  final List<String> _reasons = [
    'Tempo de espera muito longo',
    'Mudança de planos',
    'Motorista esta indo na direção errada',
    'Preocupações com segurança',
    'O motorista pediu para cancelar',
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
                    'Cancelar Viagem',
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

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp),
                child: Column(
                  children: [

                    // ── Header Card ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: sw * 0.05,
                        vertical: sh * 0.022,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(sw * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Por que deseja cancelar?',
                            style: TextStyle(
                              fontSize: sw * 0.046,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF15305B),
                            ),
                          ),
                          SizedBox(height: sh * 0.008),
                          Text(
                            'Selecione o motivo do cancelamento para nos ajudar a melhorar o serviço EK.',
                            style: TextStyle(
                              fontSize: sw * 0.036,
                              color: const Color(0xFF888888),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: sh * 0.018),

                    // ── Radio Options Card ──
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(sw * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: List.generate(_reasons.length, (index) {
                          final isLast = index == _reasons.length - 1;
                          return Column(
                            children: [
                              InkWell(
                                onTap: () =>
                                    setState(() => _selectedIndex = index),
                                borderRadius: BorderRadius.only(
                                  topLeft: index == 0
                                      ? Radius.circular(sw * 0.04)
                                      : Radius.zero,
                                  topRight: index == 0
                                      ? Radius.circular(sw * 0.04)
                                      : Radius.zero,
                                  bottomLeft: isLast
                                      ? Radius.circular(sw * 0.04)
                                      : Radius.zero,
                                  bottomRight: isLast
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
                                      // Label
                                      Expanded(
                                        child: Text(
                                          _reasons[index],
                                          style: TextStyle(
                                            fontSize: sw * 0.038,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      // Radio button
                                      GestureDetector(
                                        onTap: () => setState(
                                                () => _selectedIndex = index),
                                        child: Container(
                                          width: sw * 0.055,
                                          height: sw * 0.055,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: _selectedIndex == index
                                                  ? const Color(0xFF1A5DC8)
                                                  : const Color(0xFFCCCCCC),
                                              width: _selectedIndex == index
                                                  ? 0
                                                  : 1.5,
                                            ),
                                            color: _selectedIndex == index
                                                ? const Color(0xFF1A5DC8)
                                                : Colors.transparent,
                                          ),
                                          child: _selectedIndex == index
                                              ? Icon(
                                            Icons.circle,
                                            size: sw * 0.028,
                                            color: Colors.white,
                                          )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: sw * 0.05,
                                  endIndent: sw * 0.05,
                                  color: const Color(0xFFEEEEEE),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: sh * 0.04),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ──
            Padding(
              padding: EdgeInsets.fromLTRB(hp, 0, hp, sh * 0.035),
              child: Column(
                children: [
                  // Confirmar Cancelamento button
                  SizedBox(
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
                          // Handle cancellation confirmation
                          final selected = _reasons[_selectedIndex];
                          debugPrint('Cancellation reason: $selected');
                          Navigator.maybePop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(sw * 0.034),
                          ),
                        ),
                        child: Text(
                          'Confirmar Cancelamento',
                          style: TextStyle(
                            fontSize: sw * 0.044,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: sh * 0.014),

                  // Manter Viagem button
                  SizedBox(
                    width: double.infinity,
                    height: sh * 0.065,
                    child: OutlinedButton(
                      onPressed: () => Navigator.maybePop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: const Color(0xFF1A5DC8),
                          width: sw * 0.004,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.034),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Manter Viagem',
                        style: TextStyle(
                          fontSize: sw * 0.044,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A5DC8),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}