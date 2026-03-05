import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_go/screens/report_misconduct/report_miscunduct.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    this.phoneNumber = '+91 77777 88888',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _otpLength = 5;

  final List<TextEditingController> _controllers =
  List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(_otpLength, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final sw = mq.size.width;
    final sh = mq.size.height;
    final hp = sw * 0.06;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.025),

              // ── Back button ─────────────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: sw * 0.10,
                  height: sw * 0.10,
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
                    size: sw * 0.065,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),

              // ── Title ───────────────────────────────────────────────
              Text(
                'Verificação por OTP',
                style: TextStyle(
                  fontSize: sw * 0.063,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E),
                  height: 1.2,
                ),
              ),

              SizedBox(height: sh * 0.009),

              // ── Subtitle ────────────────────────────────────────────
              Text(
                'Digite o OTP enviado para ${widget.phoneNumber}',
                style: TextStyle(
                  fontSize: sw * 0.036,
                  color: const Color(0xFF8A8A9A),
                  height: 1.4,
                ),
              ),

              SizedBox(height: sh * 0.04),

              // ── OTP label ───────────────────────────────────────────
              Text(
                'OTP',
                style: TextStyle(
                  fontSize: sw * 0.038,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
              ),

              SizedBox(height: sh * 0.016),

              // ── 5 OTP boxes ─────────────────────────────────────────
              LayoutBuilder(
                builder: (context, constraints) {
                  final totalGap = sw * 0.03 * 4;
                  final boxSize = (constraints.maxWidth - totalGap) / 5;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_otpLength, (i) {
                      return _OtpBox(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        boxSize: boxSize,
                        screenWidth: sw,
                        onChanged: (val) => _onChanged(val, i),
                      );
                    }),
                  );
                },
              ),

              SizedBox(height: sh * 0.06),

              // ── Obter OTP Button — gradient #2D66C1 → #15305B ───────
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportMisconductScreen()));
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
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2D66C1).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Obter OTP',
                    style: TextStyle(
                      fontSize: sw * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.025),

              // ── Resend ──────────────────────────────────────────────
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não recebeu ainda?  ',
                      style: TextStyle(
                        fontSize: sw * 0.037,
                        color: const Color(0xFF8A8A9A),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Reenviar',
                        style: TextStyle(
                          fontSize: sw * 0.037,
                          color: const Color(0xFF2D66C1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Individual OTP box ─────────────────────────────────────────────────────
class _OtpBox extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final double boxSize;
  final double screenWidth;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.boxSize,
    required this.screenWidth,
    required this.onChanged,
  });

  @override
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (mounted) setState(() => _isFocused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.boxSize,
      height: widget.boxSize,
      decoration: BoxDecoration(
        // ✅ Grey box — matches image exactly
        color: const Color(0xFFE2E4EC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _isFocused ? const Color(0xFF2D66C1) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
          fontSize: widget.screenWidth * 0.055,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1A2E),
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}