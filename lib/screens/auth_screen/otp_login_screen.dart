import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';

import '../home_dashboard/home.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  Country selectedCountry = Country(
    phoneCode: "244",
    countryCode: "AO",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Angola",
    example: "Angola",
    displayName: "Angola",
    displayNameNoCountryCode: "Angola",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    // Ensure status bar icons are dark
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    final Size size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light off-white background
      resizeToAvoidBottomInset: false, // Prevents screen from moving up when keyboard opens
      body: Stack(
        children: [
          // ── MAP BACKGROUND ──────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: h * 0.49,
            child: Opacity(
              opacity: 0.15, // Very light map background
              child: Image.asset(
                'assets/customer side/images/maps.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── CENTERED LOGO ───────────────────────────────────────────
          Positioned(
            top: h * 0.09,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: w * 0.25,
                  height: w * 0.25,
                  child: Image.asset(
                    'assets/customer side/images/logo1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: h * 0.01),
                // Text(
                //   'Move-GO',
                //   style: TextStyle(
                //     fontSize: w * 0.055,
                //     fontWeight: FontWeight.w800,
                //     color: const Color(0xFF15305B),
                //     letterSpacing: 0.5,
                //   ),
                // ),
              ],
            ),
          ),

          // ── MAIN CONTENT CONTAINER ───────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: h * 0.75, // Covers bottom 70% of the screen
            child: Container(
              padding: EdgeInsets.only(
                top: h * 0.04,
                left: w * 0.06,
                right: w * 0.06,
                bottom: h * 0.03,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * 0.08),
                  topRight: Radius.circular(w * 0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Bem-vindo',
                    style: TextStyle(
                      fontSize: w * 0.075,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF15305B),
                    ),
                  ),
                  SizedBox(height: h * 0.015),

                  // Subtitle
                  Text(
                    'Insira seu numero de telefone para começar.',
                    style: TextStyle(
                      fontSize: w * 0.042,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: h * 0.04),

                  // Inputs Header (Pais & Number)
                  Row(
                    children: [
                      SizedBox(
                        width: w * 0.28,
                        child: Text(
                          'Pais',
                          style: TextStyle(
                            fontSize: w * 0.038,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'Número De Telefone',
                        style: TextStyle(
                          fontSize: w * 0.038,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),

                  // Input Box Container
                  Container(
                    height: h * 0.07,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                    child: Row(
                      children: [
                        // Country Code Dropdown
                        InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCountry = country;
                                });
                              },
                            );
                          },
                          child: Container(
                            width: w * 0.28,
                            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '+${selectedCountry.phoneCode}',
                                  style: TextStyle(
                                    fontSize: w * 0.042,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                  size: w * 0.06,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Divider
                        Container(
                          width: 1,
                          height: h * 0.04,
                          color: Colors.grey[300],
                        ),
                        // TextField
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '9XX XXX XXX',
                                hintStyle: TextStyle(
                                  fontSize: w * 0.042,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[500],
                                ),
                              ),
                              style: TextStyle(
                                fontSize: w * 0.045,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.04),

                  // Terms and Conditions RichText
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: w * 0.035,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      children: const [
                        TextSpan(text: 'Ao continuar, voce concorda com os nossos '),
                        TextSpan(
                          text: 'Termos\ne Condições e Politica de Privacidade.',
                          style: TextStyle(
                            color: Color(0xFF2D66C1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Continuar Gradient Button
                  Container(
                    width: double.infinity,
                    height: h * 0.075,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2D66C1), Color(0xFF15305B)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(w * 0.03),
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
                        // Handle continue action
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeDashboard()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                      ),
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  // Help Text
                  Center(
                    child: Text(
                      'Precisa de ajuda?',
                      style: TextStyle(
                        fontSize: w * 0.040,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
