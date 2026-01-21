import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String? selectedChat; // 👈 NO CHAT SELECTED INITIALLY

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        return Container(
          color: const Color(0xFFF6F8FB),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Messages',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // ================= LEFT CHAT LIST =================
                      SizedBox(width: isWide ? 280 : 220, child: _chatList()),

                      const VerticalDivider(width: 32),

                      // ================= RIGHT PANEL =================
                      Expanded(
                        child: selectedChat == null
                            ? _emptyChatState()
                            : _chatWindow(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= LEFT: CHAT LIST =================
  Widget _chatList() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search Patients...',
            hintStyle: const TextStyle(fontSize: 12),
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFFF2F4F8),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedChat = 'Emily Davis'; // 👈 OPEN CHAT
                  });
                },
                child: _chatListItem(isActive: selectedChat != null),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _chatListItem({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F0FF) : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emily Davis',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text(
                  '33 / F | B+ve',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= EMPTY STATE =================
  Widget _emptyChatState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No recent chats',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Select a contact to start messaging',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ================= CHAT WINDOW =================
  Widget _chatWindow() {
    return Column(
      children: [
        _chatHeader(),
        const Divider(height: 1),
        Expanded(child: _messages()),
        const Divider(height: 1),
        _messageInput(),
      ],
    );
  }

  Widget _chatHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=32',
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emily Davis',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'ID: PAT - 001',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.call_outlined),
              SizedBox(width: 16),
              Icon(Icons.videocam_outlined),
              SizedBox(width: 16),
              Icon(Icons.info_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messages() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ReceivedMessage(text: 'Hello Doctor'),
        _SentMessage(text: 'Hi Emily, how can I help?'),
        _ReceivedMessage(text: 'I need prescription advice'),
      ],
    );
  }

  Widget _messageInput() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.add, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message...',
                filled: true,
                fillColor: const Color(0xFFF2F4F8),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.mic, color: Colors.grey),
        ],
      ),
    );
  }
}

// ================= MESSAGE BUBBLES =================

class _SentMessage extends StatelessWidget {
  final String text;
  const _SentMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF5B7CFF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}

class _ReceivedMessage extends StatelessWidget {
  final String text;
  const _ReceivedMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(text, style: const TextStyle(fontSize: 13)),
      ),
    );
  }
}
