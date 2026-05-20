import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, String>> _messages = [];
  final List<String> _chatHistory = [];

  bool _isLoading = false;
  String? _sessionId;

  final String agentUrl =
      'https://adk-default-service-name-981263875984.us-central1.run.app';
  final String appName = 'data_analyst_agent';
  final String userId = 'user';

  @override
  void initState() {
    super.initState();
    _createSession();
  }

  Future<void> _createSession() async {
    try {
      final response = await http.post(
        Uri.parse('$agentUrl/apps/$appName/users/$userId/sessions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _sessionId = data['id'];
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'agent',
          'text': 'تعذر الاتصال بالمرشد السياحي حاليًا.',
        });
      });
    }
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    if (_sessionId == null) {
      setState(() {
        _messages.add({
          'role': 'agent',
          'text': 'جاري تجهيز المحادثة، حاولي بعد لحظات.',
        });
      });
      return;
    }

    setState(() {
      _messages.add({'role': 'user', 'text': message});
      _chatHistory.add(message);
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$agentUrl/run'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'appName': appName,
          'userId': userId,
          'sessionId': _sessionId,
          'newMessage': {
            'role': 'user',
            'parts': [
              {'text': message}
            ]
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String reply = 'لم أستطع فهم الرد.';

        if (data is List && data.isNotEmpty) {
          reply = data.last['content']['parts'][0]['text'] ?? reply;
        }

        setState(() {
          _messages.add({'role': 'agent', 'text': reply});
        });
      } else {
        setState(() {
          _messages.add({
            'role': 'agent',
            'text': 'حدث خطأ في الاتصال، حاولي مرة ثانية.',
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'agent',
          'text': 'حدث خطأ، تأكدي من الاتصال بالإنترنت.',
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _controller.clear();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
  final XFile? image = await _picker.pickImage(source: source);

  if (image == null) return;

  if (_sessionId == null) {
    setState(() {
      _messages.add({
        'role': 'agent',
        'text': 'جاري تجهيز المحادثة، حاولي بعد لحظات.',
      });
    });
    return;
  }

  final bytes = await image.readAsBytes();
  final base64Image = base64Encode(bytes);

  setState(() {
    _messages.add({
      'role': 'user',
      'text': source == ImageSource.camera
          ? '📷 أرسلت صورة من الكاميرا'
          : '🖼 أرسلت صورة من المعرض',
    });
    _isLoading = true;
  });

  try {
    final response = await http.post(
      Uri.parse('$agentUrl/run'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'appName': appName,
        'userId': userId,
        'sessionId': _sessionId,
        'newMessage': {
          'role': 'user',
          'parts': [
            {
              'text': 'حلل هذه الصورة وأخبرني بما يظهر فيها، وهل لها علاقة بالسياحة في حائل؟'
            },
            {
              'inlineData': {
                'mimeType': image.mimeType ?? 'image/jpeg',
                'data': base64Image,
              }
            }
          ]
        }
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      String reply = 'لم أستطع تحليل الصورة.';

      if (data is List && data.isNotEmpty) {
        reply = data.last['content']['parts'][0]['text'] ?? reply;
      }

      setState(() {
        _messages.add({'role': 'agent', 'text': reply});
      });
    } else {
      setState(() {
        _messages.add({
          'role': 'agent',
          'text': 'تعذر إرسال الصورة للشات بوت.',
        });
      });
    }
  } catch (e) {
    setState(() {
      _messages.add({
        'role': 'agent',
        'text': 'حدث خطأ أثناء إرسال الصورة.',
      });
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  void _startNewChat() {
    setState(() {
      _messages.clear();
      _sessionId = null;
    });
    _createSession();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/robot.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 1),
                const Text(
                  'سجل المحادثات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.add_comment_outlined),
                  title: const Text('محادثة جديدة'),
                  onTap: _startNewChat,
                ),
                const Divider(),
                Expanded(
                  child: _chatHistory.isEmpty
                      ? const Center(
                          child: Text('لا يوجد سجل محادثات بعد'),
                        )
                      : ListView.builder(
                          itemCount: _chatHistory.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.chat_bubble_outline),
                              title: Text(
                                _chatHistory[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: Colors.white,
  elevation: 1,
  toolbarHeight: 110,
  centerTitle: true,

  leading: Builder(
    builder: (context) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    },
  ),

  title: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        'assets/images/robot.png',
        width: 34,
        height: 34,
      ),
      const SizedBox(height: 4),
      const Text(
        'مرشدك السياحي حاتم',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Color(0xFF3B210D),
          height: 1.1,
        ),
      ),
    ],
  ),

  actions: [
    IconButton(
      icon: const Icon(Icons.arrow_forward),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ],
),
        body: Column(
          children: [
            const SizedBox(height: 20),


            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? const Color(0xFF3B210D)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: MarkdownBody(
  data: msg['text'] ?? '',
  selectable: true,
  styleSheet: MarkdownStyleSheet(
    p: TextStyle(
      color: isUser ? Colors.white : Colors.black,
      fontSize: 14,
      height: 1.5,
    ),

    strong: TextStyle(
      color: isUser ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
    ),

    h1: TextStyle(
      color: isUser ? Colors.white : Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),

    h2: TextStyle(
      color: isUser ? Colors.white : Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

    h3: TextStyle(
      color: isUser ? Colors.white : Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),

    listBullet: TextStyle(
      color: isUser ? Colors.white : Colors.black,
    ),
  ),
),
                    ),
                  );
                },
              ),
            ),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    IconButton(
                      icon: const Icon(Icons.image_outlined),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintText: 'اسأل عن السياحة في حائل...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        _sendMessage(_controller.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}