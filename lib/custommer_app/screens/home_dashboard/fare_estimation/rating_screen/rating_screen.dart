import 'package:flutter/material.dart';

import '../../../driver_mathing_screen/driver_matching.dart';

class RateYourRideScreen extends StatefulWidget {
  const RateYourRideScreen({super.key});

  @override
  State<RateYourRideScreen> createState() => _RateYourRideScreenState();
}

class _RateYourRideScreenState extends State<RateYourRideScreen> {
  int _selectedStars = 4;
  final Set<String> _selectedHighlights = {'Condução segura'};
  final TextEditingController _commentController = TextEditingController();

  final List<String> _highlights = [
    'Condução segura',
    'Carro limpo',
    'Excelente percurso',
    'Pontualidade',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,   // ← plain white, no card
      body: SafeArea(
        child: Column(
          children: [

            // ── Scrollable content ─────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: sh * 0.025),

                    // Title + Close button
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Avaliação',
                            style: TextStyle(
                              fontSize: sw * 0.058,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A5DC8),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: sw * 0.082,
                            height: sw * 0.082,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close,
                                size: sw * 0.045, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: sh * 0.032),

                    // Avatar
                    CircleAvatar(
                      radius: sw * 0.115,
                      backgroundColor: const Color(0xFFD9D9D9),
                      backgroundImage: const AssetImage(
                        'assets/customer side/images/home_images/profile.png',
                      ),
                    ),

                    SizedBox(height: sh * 0.018),

                    // Name
                    Text(
                      'João Silva',
                      style: TextStyle(
                        fontSize: sw * 0.054,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: sh * 0.005),

                    // Car info
                    Text(
                      'Toyota Prius . ABC-123-AO',
                      style: TextStyle(
                          fontSize: sw * 0.037, color: Colors.grey.shade500),
                    ),

                    SizedBox(height: sh * 0.009),

                    // Rating badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded,
                            color: const Color(0xFFFFC107), size: sw * 0.048),
                        SizedBox(width: sw * 0.010),
                        Text('4.8',
                            style: TextStyle(
                                fontSize: sw * 0.042,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)),
                        SizedBox(width: sw * 0.010),
                        Text('(127)',
                            style: TextStyle(
                                fontSize: sw * 0.038,
                                color: Colors.grey.shade500)),
                      ],
                    ),

                    SizedBox(height: sh * 0.030),

                    // Question
                    Text(
                      'Como foi sua viagem?',
                      style: TextStyle(
                        fontSize: sw * 0.054,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: sh * 0.020),

                    // Star selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedStars = i + 1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sw * 0.010),
                            child: Icon(
                              Icons.star_rounded,
                              size: sw * 0.135,
                              color: i < _selectedStars
                                  ? const Color(0xFFFFC107)
                                  : const Color(0xFFDDDDDD),
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: sh * 0.008),

                    Text(
                      'O que achou do atendimento?',
                      style: TextStyle(
                          fontSize: sw * 0.034, color: Colors.grey.shade500),
                    ),

                    SizedBox(height: sh * 0.030),

                    // Highlights title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Destaques da viagem',
                        style: TextStyle(
                          fontSize: sw * 0.046,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    SizedBox(height: sh * 0.014),

                    // Chip row 1
                    Row(
                      children: [
                        _chip(_highlights[0], sw, sh),
                        SizedBox(width: sw * 0.030),
                        _chip(_highlights[1], sw, sh),
                      ],
                    ),

                    SizedBox(height: sh * 0.012),

                    // Chip row 2
                    Row(
                      children: [
                        _chip(_highlights[2], sw, sh),
                        SizedBox(width: sw * 0.030),
                        _chip(_highlights[3], sw, sh),
                      ],
                    ),

                    SizedBox(height: sh * 0.030),

                    // Comments label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Comentários (opcional)',
                        style: TextStyle(
                          fontSize: sw * 0.046,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    SizedBox(height: sh * 0.012),

                    // Comment box
                    Container(
                      width: double.infinity,
                      height: sh * 0.145,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(sw * 0.030),
                      ),
                      padding: EdgeInsets.all(sw * 0.04),
                      child: TextField(
                        controller: _commentController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(fontSize: sw * 0.036),
                        decoration: InputDecoration(
                          hintText: 'Escreva algo sobre sua experiência ...',
                          hintStyle: TextStyle(
                              fontSize: sw * 0.036,
                              color: Colors.grey.shade400),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),

                    SizedBox(height: sh * 0.025),
                  ],
                ),
              ),
            ),

            // ── Submit button pinned at bottom ─────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sw * 0.06, sh * 0.010, sw * 0.06, sh * 0.025),
              child: SizedBox(
                width: double.infinity,
                height: sh * 0.070,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D66C1), Color(0xFF15305B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(sw * 0.034),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DriverMatchingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sw * 0.034),
                      ),
                    ),
                    child: Text(
                      'Enviar Avaliaçao',
                      style: TextStyle(
                        fontSize: sw * 0.050,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _chip(String label, double sw, double sh) {
    final bool selected = _selectedHighlights.contains(label);
    return GestureDetector(
      onTap: () => setState(() {
        selected
            ? _selectedHighlights.remove(label)
            : _selectedHighlights.add(label);
      }),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: sw * 0.044, vertical: sh * 0.012),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(sw * 0.08),
          border: Border.all(
            color: selected
                ? const Color(0xFF1A5DC8)
                : const Color(0xFFCCCCCC),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: sw * 0.035,
            fontWeight: FontWeight.w500,
            color: selected ? const Color(0xFF1A5DC8) : Colors.black87,
          ),
        ),
      ),
    );
  }
}