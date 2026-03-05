import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../otp_screen/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final screenHeight = mq.size.height;
    final horizontalPadding = screenWidth * 0.06;
    final verticalSpacing = screenHeight * 0.018;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03),

                // ── Logo + App Name ──────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      // Simple logo image — no border, no stack, no painter
                      Image.asset(
                        "assets/customer side/images/logo1.png",
                        width: screenWidth * 0.22,
                        height: screenWidth * 0.22,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: screenHeight * 0.01),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // ── Title ────────────────────────────────────────────────
                Text(
                  'Crie a sua conta',
                  style: TextStyle(
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: screenHeight * 0.006),
                Text(
                  'Junte-se ao EK-moveGo para viagens premium.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    color: const Color(0xFF7A7A8C),
                  ),
                ),

                SizedBox(height: verticalSpacing * 1.2),

                // ── Nome Completo ────────────────────────────────────────
                _buildLabel('Nome Completo', screenWidth),
                SizedBox(height: screenHeight * 0.008),
                _buildTextField(
                  controller: _nameController,
                  hintText: 'Enter your Name',
                  screenWidth: screenWidth,
                ),

                SizedBox(height: verticalSpacing),

                // ── Pais + Número De Telefone ─────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pais',
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.22),
                    Text(
                      'Número De Telefone',
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.008),
                _buildPhoneField(screenWidth, screenHeight),

                SizedBox(height: verticalSpacing),

                // ── E-Mail ───────────────────────────────────────────────
                _buildLabel('E-Mail', screenWidth),
                SizedBox(height: screenHeight * 0.008),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'exemplo@email.com',
                  keyboardType: TextInputType.emailAddress,
                  screenWidth: screenWidth,
                ),

                SizedBox(height: verticalSpacing),

                // ── Palavra-Passe ────────────────────────────────────────
                _buildLabel('Palavra-Passe', screenWidth),
                SizedBox(height: screenHeight * 0.008),
                _buildPasswordField(screenWidth),

                SizedBox(height: screenHeight * 0.06),

                // ── Continuar — gradient button #2D66C1 → #15305B ────────
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const OtpScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.065,
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
                      'Continuar',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // ── Already have account ─────────────────────────────────
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já tem uma conta?  ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.038,
                          color: const Color(0xFF7A7A8C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Iniciar Sessão',
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            color: const Color(0xFF2D66C1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double screenWidth) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth * 0.038,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required double screenWidth,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: screenWidth * 0.04,
        color: const Color(0xFF1A1A2E),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFFB0B0C0),
          fontSize: screenWidth * 0.04,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045,
          vertical: screenWidth * 0.04,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF2D66C1),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(double screenWidth, double screenHeight) {
    return IntlPhoneField(
      initialCountryCode: 'AO',
      style: TextStyle(
        fontSize: screenWidth * 0.04,
        color: const Color(0xFF1A1A2E),
      ),
      decoration: InputDecoration(
        hintText: '9XX XXX XXX',
        hintStyle: TextStyle(
          color: const Color(0xFFB0B0C0),
          fontSize: screenWidth * 0.04,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.04,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF2D66C1),
            width: 1.5,
          ),
        ),
      ),
      dropdownTextStyle: TextStyle(
        fontSize: screenWidth * 0.04,
        color: const Color(0xFF1A1A2E),
        fontWeight: FontWeight.w500,
      ),
      flagsButtonPadding: EdgeInsets.only(left: screenWidth * 0.03),
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: const Color(0xFF1A1A2E),
        size: screenWidth * 0.05,
      ),
      onChanged: (phone) {},
    );
  }

  Widget _buildPasswordField(double screenWidth) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: TextStyle(
        fontSize: screenWidth * 0.04,
        color: const Color(0xFF1A1A2E),
      ),
      decoration: InputDecoration(
        hintText: '••••••••••••',
        hintStyle: TextStyle(
          color: const Color(0xFFB0B0C0),
          fontSize: screenWidth * 0.04,
          letterSpacing: 2,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045,
          vertical: screenWidth * 0.04,
        ),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscurePassword = !_obscurePassword),
          child: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: const Color(0xFFB0B0C0),
            size: screenWidth * 0.055,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF2D66C1),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}