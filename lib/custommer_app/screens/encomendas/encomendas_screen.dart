
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EncomendasScreen extends StatelessWidget {
  const EncomendasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double horizontalPadding = screenWidth * 0.05;
    final double verticalSpacing = screenHeight * 0.018;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar
            _buildAppBar(context, screenWidth, horizontalPadding),

            SizedBox(height: verticalSpacing * 0.5),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enviar Nova Encomenda Button
                    _buildEnviarButton(context, screenWidth),

                    SizedBox(height: verticalSpacing),

                    // Entrega Ativa Section
                    _buildEntregaAtivaSection(context, screenWidth, screenHeight),

                    SizedBox(height: verticalSpacing),

                    // Entregas Anteriores Header
                    _buildEntregasAnterioresHeader(context, screenWidth),

                    SizedBox(height: verticalSpacing * 0.6),

                    // Encomenda #7842
                    _buildEncomendaCard(
                      context,
                      screenWidth,
                      numero: '#7842',
                      data: '12 Out, 2023',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+1.200 Kz',
                            style: TextStyle(
                              color: const Color(0xFF34C759),
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.038,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          Text(
                            'Concluído',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.032,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.012),

                    // Encomenda #7810
                    _buildEncomendaCard(
                      context,
                      screenWidth,
                      numero: '#7810',
                      data: '05 Out, 2023',
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF34C759).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Entregue',
                          style: TextStyle(
                            color: const Color(0xFF34C759),
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.033,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: verticalSpacing),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(
      BuildContext context, double screenWidth, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: MediaQuery.of(context).size.height * 0.015,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                width: screenWidth * 0.09,
                height: screenWidth * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: const Color(0xFF1A1A2E),
                  size: screenWidth * 0.08,
                ),
              ),
            ),
          ),
          // Title
          Text(
            'Encomendas',
            style: TextStyle(
              fontSize: screenWidth * 0.052,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnviarButton(BuildContext context, double screenWidth) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.add,
          color: const Color(0xFF1C6EF2),
          size: screenWidth * 0.05,
        ),
        label: Text(
          'Enviar Nova Encomenda',
          style: TextStyle(
            color: const Color(0xFF1C6EF2),
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.018,
          ),
          side: const BorderSide(color: Color(0xFF1C6EF2), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEntregaAtivaSection(
      BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entrega Ativa',
          style: TextStyle(
            fontSize: screenWidth * 0.038,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.045),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: ESTAFETA + Em Trânsito badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ESTAFETA',
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.8,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Em Trânsito',
                      style: TextStyle(
                        color: const Color(0xFF34C759),
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.032,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.006),

              // Courier name
              Text(
                'Ricardo Santos',
                style: TextStyle(
                  fontSize: screenWidth * 0.048,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),

              SizedBox(height: screenHeight * 0.014),

              // Origin
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: const Color(0xFF1C6EF2),
                    size: screenWidth * 0.048,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Sua localização',
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.008),

              // Destination
              Row(
                children: [
                  Icon(
                    Icons.radio_button_checked,
                    color: Colors.grey[400],
                    size: screenWidth * 0.045,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Avenida Comandante Gika, Luanda',
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.016),

              // Rastrear Entrega Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.014,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    'Rastrear Entrega',
                    style: TextStyle(
                      color: const Color(0xFF1C6EF2),
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEntregasAnterioresHeader(
      BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Entregas Anteriores',
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Ver tudo',
            style: TextStyle(
              fontSize: screenWidth * 0.038,
              color: const Color(0xFF1C6EF2),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEncomendaCard(
      BuildContext context,
      double screenWidth, {
        required String numero,
        required String data,
        required Widget trailing,
      }) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.016,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon box
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: Colors.grey[600],
              size: screenWidth * 0.06,
            ),
          ),

          SizedBox(width: screenWidth * 0.04),

          // Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Encomenda $numero',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  data,
                  style: TextStyle(
                    fontSize: screenWidth * 0.034,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Trailing widget
          trailing,
        ],
      ),
    );
  }
}