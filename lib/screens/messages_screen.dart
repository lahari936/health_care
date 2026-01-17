import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
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
                      SizedBox(
                        width: isWide ? 280 : 220,
                        child: _chatList(),
                      ),

                      const VerticalDivider(width: 32),

                      // ================= CHAT WINDOW =================
                      Expanded(
                        child: _chatWindow(),
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
              return _chatListItem(isActive: index == 0);
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
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=32',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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

  // ================= RIGHT: CHAT WINDOW =================
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
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=32',
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
        _CenterProfile(),
        _ReceivedMessage(
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
        ),
        _SentMessage(
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        _ReceivedMessage(
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
        ),
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
        child: Text(
          text,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}

class _CenterProfile extends StatelessWidget {
  const _CenterProfile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: const [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=32',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Emily Davis',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            'ID: PAT - 001 | 33 / F | B+ve',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 6),
          Text(
            'View Profile',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
