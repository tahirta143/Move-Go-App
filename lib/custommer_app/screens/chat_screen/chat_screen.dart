import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final String time;
  final bool isMe;

  const ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showMenu = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    const ChatMessage(
      text: 'Olá! Já estou a caminho do ponto de encontro. Chego em 3 minutos.',
      time: '12:30 AM',
      isMe: false,
    ),
    const ChatMessage(
      text: 'Perfeito, já estou a sair do edifício.',
      time: '12:30 AM',
      isMe: true,
    ),
  ];

  String _getFormattedTime() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        time: _getFormattedTime(),
        isMe: true,
      ));
      _controller.clear();
    });

    // Auto-scroll to bottom after sending
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final double horizontalPadding = screenWidth * 0.045;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (_showMenu) setState(() => _showMenu = false);
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Column(
                children: [
                  // ── App Bar ──
                  _buildAppBar(screenWidth, screenHeight, horizontalPadding),

                  // ── Messages Area ──
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: screenHeight * 0.02,
                      ),
                      itemCount: _messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              _buildDateSeparator('Today 12:15 AM', screenWidth),
                              SizedBox(height: screenHeight * 0.025),
                            ],
                          );
                        }
                        final message = _messages[index - 1];
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                          child: message.isMe
                              ? _buildSentMessage(message, screenWidth, screenHeight)
                              : _buildReceivedMessage(message, screenWidth, screenHeight),
                        );
                      },
                    ),
                  ),

                  // ── Input Bar ──
                  _buildInputBar(screenWidth, screenHeight, horizontalPadding),
                ],
              ),

              // ── Dropdown Menu ──
              if (_showMenu)
                Positioned(
                  top: screenHeight * 0.085,
                  right: horizontalPadding,
                  child: _buildDropdownMenu(screenWidth, screenHeight),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── App Bar ──
  Widget _buildAppBar(double sw, double sh, double hp) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: sh * 0.015),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, size: sw * 0.05, color: Colors.black),
          ),
          SizedBox(width: sw * 0.03),
          CircleAvatar(
            radius: sw * 0.06,
            backgroundColor: const Color(0xFFBDBDBD),
            backgroundImage: const AssetImage('assets/images/driver.png'),
            onBackgroundImageError: (_, __) {},
            child: const Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: sw * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'António Manuel',
                  style: TextStyle(
                    fontSize: sw * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: sh * 0.003),
                Text(
                  'Toyota Corolla . ABC-1234',
                  style: TextStyle(
                    fontSize: sw * 0.033,
                    color: const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _showMenu = !_showMenu),
            child: Padding(
              padding: EdgeInsets.all(sw * 0.02),
              child: Icon(Icons.more_vert, size: sw * 0.06, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // ── Date Separator ──
  Widget _buildDateSeparator(String label, double sw) {
    return Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: sw * 0.035,
          color: const Color(0xFF999999),
        ),
      ),
    );
  }

  // ── Received Message ──
  Widget _buildReceivedMessage(ChatMessage msg, double sw, double sh) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: sw * 0.045,
          backgroundColor: const Color(0xFFBDBDBD),
          backgroundImage: const AssetImage('assets/images/driver.png'),
          onBackgroundImageError: (_, __) {},
          child: const Icon(Icons.person, color: Colors.white, size: 16),
        ),
        SizedBox(width: sw * 0.025),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04,
                  vertical: sh * 0.014,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                    bottomLeft: Radius.circular(4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  msg.text,
                  style: TextStyle(
                    fontSize: sw * 0.038,
                    color: Colors.black,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: sh * 0.005),
              Padding(
                padding: EdgeInsets.only(left: sw * 0.02),
                child: Text(
                  msg.time,
                  style: TextStyle(
                    fontSize: sw * 0.030,
                    color: const Color(0xFF999999),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: sw * 0.15),
      ],
    );
  }

  // ── Sent Message ──
  Widget _buildSentMessage(ChatMessage msg, double sw, double sh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: sw * 0.1),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: sw * 0.045,
              vertical: sh * 0.014,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A3A6B), Color(0xFF2D66C1)],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  msg.text,
                  style: TextStyle(
                    fontSize: sw * 0.038,
                    color: Colors.white,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: sh * 0.005),
                Text(
                  msg.time,
                  style: TextStyle(
                    fontSize: sw * 0.030,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Input Bar ──
  Widget _buildInputBar(double sw, double sh, double hp) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: hp * 0.8,
        vertical: sh * 0.013,
      ),
      child: Row(
        children: [
          // Plus button
          Container(
            width: sw * 0.1,
            height: sw * 0.1,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F0F0),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.black54, size: sw * 0.055),
          ),

          SizedBox(width: sw * 0.03),

          // Text field
          Expanded(
            child: Container(
              height: sh * 0.055,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                style: TextStyle(fontSize: sw * 0.038),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Mensagem ...',
                  hintStyle: TextStyle(
                    color: const Color(0xFFAAAAAA),
                    fontSize: sw * 0.038,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sw * 0.04,
                    vertical: sh * 0.014,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: sw * 0.03),

          // Mic button
          Icon(Icons.mic_none, color: Colors.black54, size: sw * 0.065),

          SizedBox(width: sw * 0.03),

          // Send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: sw * 0.12,
              height: sw * 0.12,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A3A6B), Color(0xFF2A5298)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: Colors.white, size: sw * 0.055),
            ),
          ),
        ],
      ),
    );
  }

  // ── Dropdown Menu ──
  Widget _buildDropdownMenu(double sw, double sh) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withOpacity(0.15),
      child: Container(
        width: sw * 0.38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => setState(() => _showMenu = false),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.05,
                  vertical: sh * 0.018,
                ),
                child: Text(
                  'Call Now',
                  style: TextStyle(fontSize: sw * 0.04, color: Colors.black),
                ),
              ),
            ),
            Divider(height: 1, color: const Color(0xFFEEEEEE)),
            GestureDetector(
              onTap: () {
                setState(() {
                  _messages.clear();
                  _showMenu = false;
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.05,
                  vertical: sh * 0.018,
                ),
                child: Text(
                  'Clear Chat',
                  style: TextStyle(fontSize: sw * 0.04, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}